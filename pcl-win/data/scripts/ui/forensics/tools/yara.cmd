@echo off

:: usage:  yara [OPTION]... RULES_FILE FILE | PID
::options:
::  -t <tag>                 only print rules tagged as <tag>.
::  -i <identifier>          only print rules named <identifier>.
::  -n                       only print not satisfied rules (negate).
::  -g                       print tags.
::  -m                       print metadata.
::  -s                       print matching strings.
::  -p <number>              use the specified <number> of threads to scan a directory.
::  -l <number>              abort scanning after matching a number rules.
::  -a <seconds>             abort scanning after a number of seconds has elapsed.
::  -d <identifier>=<value>  define external variable.
::  -x <module>=<file>       pass file's content as extra data to module.
::  -r                       recursively search directories.
::  -f                       fast matching mode.
::  -w                       disable warnings.
::  -v                       show version information.


:end

