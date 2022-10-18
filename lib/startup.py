import os

if os.environ.get('AWS_EXECUTION_ENV'):
    import sys
    sys.path.append('/var/task/lib/packages')
