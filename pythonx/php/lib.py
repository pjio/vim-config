import re
import os
import vim
import subprocess


def insert_indent(lines, row):
    if len(lines) == 0:
        return

    vim.command('%d' % row)
    vim.current.buffer[row:row] = lines

    vim.command("normal j")
    if len(lines) == 1:
        vim.command("normal V=")
    else:
        vim.command("normal V" + str(len(lines) - 1) + "j=")


def find_row(start, pattern, direction):
    if direction == 'up':
        search_lines = reversed(range(0, start))
    else:
        search_lines = range(start, len(vim.current.buffer) - 1)

    for row in search_lines:
        if re.match(pattern, vim.current.buffer[row]):
            return row
    return None


def find_in_rows(rows, pattern):
    for row in rows:
        match = re.match(pattern, vim.current.buffer[row])
        if match:
            return match.group(1)
    return None


def fetch_class_info():
    buf = '\n'.join(vim.current.buffer[:])
    namespace     = None
    classname     = None
    fqcn          = None
    use_statement = None

    match = re.search(r'^(?: *<\?php)? *namespace (.*) *;', buf, re.MULTILINE)
    if match:
        namespace = match.group(1)

    match = re.search(r'^ *(?:(?:abstract|final) +)?(?:class|interface|trait) +([a-z0-9_]+)', buf, re.MULTILINE | re.IGNORECASE)
    if match:
        classname = match.group(1)

    if namespace and classname:
        fqcn = '%s\\%s' % (namespace, classname)
    elif classname:
        fqcn = classname

    if fqcn:
        use_statement = 'use %s;' % fqcn

    return (namespace, classname, fqcn, use_statement)


def get_function_parameter(start_row):
    try:
        buf = '\n'.join(vim.current.buffer[start_row:])
        mf = re.match(r'^.*?function\s+\w+\s*\((.*?)\)[\s\r\n]*(?::[\s\r\n]*\??\w+)?[\s\r\n]*\{', buf, re.DOTALL)
        if not mf:
            raise Exception("function not found!")
        mp = re.finditer(r'(?:([a-z0-9_\\\\]+) +)?(\$[a-zA-Z0-9_]+)', mf.group(1), re.IGNORECASE)
        return [[match.group(1), match.group(2)] for match in mp]
    except Exception as e:
        print(e)
        return []


def get_function_return_type(start_row):
    buf = '\n'.join(vim.current.buffer[start_row:])
    match = re.search(r'^.*?function\s+\w+\s*\(.*?\)[\s\r\n]*(?::[\s\r\n]*(\??\w+))?[\s\r\n]*\{', buf, re.MULTILINE | re.IGNORECASE)
    if not match:
        return ''
    return match.group(1)


def get_properties():
    try:
        buf = '\n'.join(vim.current.buffer[:])
        mp = re.finditer(r'(?:private|protected|public)\s+(?:(\??[a-zA-Z0-9_\\\\]+)\s+)?(\$[a-zA-Z0-9_]+)', buf)
        return [str(match.group(2)) for match in mp]
    except Exception as e:
        print(e)
        return []


def unique(list):
    unique = []
    [unique.append(item) for item in list if item not in unique]
    return unique
