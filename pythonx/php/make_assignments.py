import re
import vim
from .lib import find_row, get_properties, get_function_parameter, insert_indent

def php_make_assignments():
    function_start, function_end = get_function_bounds()
    if function_start == None or function_end == None:
        return

    properties           = get_properties()
    params               = get_function_parameter(function_start)
    existing_assignments = get_existing_assignments(function_start, function_end)

    assignments = []
    for param in params:
        param_name = param[1]
        if param_name in properties and param_name.replace('$', '') not in existing_assignments:
            assignments.append("$this->" + re.sub('^\$', '', param_name) + " = " + param_name + ";")
    insert_indent(assignments, function_end)

def get_existing_assignments(start, end):
    try:
        buf = '\n'.join(vim.current.buffer[start:end])
        mp = re.finditer('\$this->([a-z0-9_]+) *= *\$[a-z0-9_]+ *;', buf, re.DOTALL | re.IGNORECASE)
        return [str(match.group(1)) for match in mp]
    except Exception as e:
        print(e.message)
        return []

def get_function_bounds():
    (row, col) = vim.current.window.cursor
    function_start = find_row(row, '.*function ', 'up')

    if function_start == None:
        return None, None

    indention = get_indention(function_start)
    function_end = find_row(0 if row == 0 else row - 1, '^%s\}' % indention, 'down')

    if function_end == None:
        return None, None

    return function_start, function_end

def get_indention(row):
    return re.match('^([ \t]*)', vim.current.buffer[row]).group(1)

