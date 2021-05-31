import vim
from .lib import fetch_class_info

def copy_file_values():
    vim.command('let @" = @%')

    filetype = vim.eval('&filetype')
    if filetype == 'php':
        namespace, classname, fqcn, use_statement = fetch_class_info()

        namespace     = namespace.replace('\\', '\\\\')            if namespace != None else ''
        classname     = classname.replace('\\', '\\\\')            if classname != None else ''
        fqcn          = fqcn.replace('\\', '\\\\')                 if fqcn != None else ''
        use_statement = use_statement.replace('\\', '\\\\')        if use_statement != None else ''
        varname       = '$' + classname[0].lower() + classname[1:] if classname != '' else ''

        vim.command('let @n = "%s"' % namespace)
        vim.command('let @b = "%s\\n"' % use_statement)
        vim.command('let @c = "%s"' % classname)
        vim.command('let @m = "%s"' % fqcn)
        vim.command('let @v = "%s"' % varname)

