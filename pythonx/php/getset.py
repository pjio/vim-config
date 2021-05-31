import re
import vim
from .lib import find_in_rows, insert_indent

rx_find_docblock = '^.*@var +([a-zA-Z0-9_\\\]+(?:\[\])?)'
rx_match_property = re.compile('^[ \t]*(?:private|protected|public)\s+(?:(\??[a-zA-Z0-9_\\\]+)\s+)?(\$[a-zA-Z0-9_]+) *(?:= *[^;]+)?;')
rx_filter_property_name = re.compile('^.*\$([a-z0-9_]+)')
rx_filter_variable_name = re.compile('^_')
rx_match_functionnames = re.compile('[ \t]function\s+([a-zA-Z0-9_]+) *\(')
rx_is_array_type = re.compile('^array$|\[\]$')

def php_make_getter_and_setter():
    match = rx_match_property.match(vim.current.line)
    if not match:
        return

    typehint = match.group(1)
    property_name = rx_filter_property_name.sub('\\1', match.group(2))
    variable_name = rx_filter_variable_name.sub('', property_name)
    partname = '%s%s' % (variable_name[0].upper(), variable_name[1:])
    setter_name = 'set%s' % partname
    getter_name = 'get%s' % partname

    (row, col) = vim.current.window.cursor
    typename = None
    casttype = None
    if typehint == None and row >= 3:
        typename = find_in_rows(reversed(range(row - 3, row - 1)), rx_find_docblock)
        if typename == None:
            typehint = None
        elif is_array_type(typename):
            typehint = 'array'
        elif is_scalar_type(typename):
            # casttype = typename
            typehint = typename
        elif typename != None:
            typehint = typename

    messages = []
    lines = []
    functions = get_functions()

    if getter_name in functions:
        messages.append('%s already exists' % getter_name)
    else:
        getter = ['']
        if typename != None:
            getter += [
                '/**',
                ' * @return %s' % typename,
                ' */'
            ]
        getter += [
            'public function %s()%s' % (getter_name, ': %s' % typehint if typehint != None else ''),
            '{',
            '	return $this->%s;' % property_name,
            '}',
        ]
        lines += getter
        messages.append('%s created' % getter_name)

    if setter_name in functions:
        messages.append('%s already exists' % setter_name)
    else:
        setter = ['']
        if typename != None:
            setter += [
                '/**',
                ' * @param %s $%s' % (typename, variable_name),
                #' *',
                #' * @return $this',
                ' */'
            ]
        setter += [
                'public function %s(%s$%s): void' % (setter_name, '%s ' % typehint if typehint != None else '', variable_name),
            '{',
            '	$this->%s = %s$%s;' % (property_name, '(%s)' % casttype if casttype != None else '', variable_name),
            #'	return $this;',
            '}',
        ]
        lines += setter
        messages.append('%s created' % setter_name)

    insert_indent(lines, row)
    print(', '.join(messages))

def get_functions():
    try:
        buf = '\n'.join(vim.current.buffer[:])
        mp = rx_match_functionnames.finditer(buf)
        return [str(match.group(1)) for match in mp]
    except Exception as e:
        print(e.message)
        return []

def is_scalar_type(typename):
    return True if typename in ['string', 'int', 'integer', 'bool', 'boolean', 'float'] else False

def is_array_type(typename):
    if rx_is_array_type.search(typename):
        return True
    return False

