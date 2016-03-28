@echo off

MsiExec.exe /X{BD95A8CD-1D9F-35AD-981A-3E7925026EBB}
MsiExec.exe /X{B175520C-86A2-35A7-8619-86DC379688B9}
"C:\ProgramData\Package Cache\{33d1fd90-4274-48a1-9bc1-97e33d9c2d6f}\vcredist_x86.exe" /uninstall /quiet