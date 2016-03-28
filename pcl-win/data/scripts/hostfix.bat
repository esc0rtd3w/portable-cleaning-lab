@echo off

echo,Y|cacls "%WinDir%\system32\drivers\etc\hosts" /G everyone:f
attrib -s -h -r "%WinDir%\system32\drivers\etc\hosts"