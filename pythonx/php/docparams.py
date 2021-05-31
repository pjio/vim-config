import vim
from .lib import get_function_parameter, get_function_return_type, insert_indent, find_row

def php_doc_params():
    (row, col) = vim.current.window.cursor
    row = find_row(row, '.*function ', 'up')
    if row is None:
        return

    params = get_function_parameter(row)
    return_type = get_function_return_type(row)
    if return_type == 'void':
        return_type = None
    indent = '  ' if return_type else ' '

    docblock = ['/**']
    docblock += [' * @param%s%s%s' % (indent, '' if param[0] is None else '%s ' % param[0], param[1]) for param in params]
    if return_type:
        docblock += [' * @return %s' % return_type.replace('?', 'null|')]
    docblock.append(' */')
    insert_indent(docblock, row)
