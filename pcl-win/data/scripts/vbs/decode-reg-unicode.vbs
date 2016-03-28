inputString=WScript.Arguments.Item(0)
intLen = Len(inputString)-1
redim arrChars(intLen)
For intCounter = 0 to intLen Step 2
	arrChars(intCounter) = CStr(CLng("&H" & Mid(inputString, intCounter + 1,2)))
	'wscript.echo intCounter& " Hexa :" & Mid(inputString, intCounter + 1,2) & " Dec : " & arrChars(intCounter) & " Char : "  & chr(arrChars(intCounter))
	Str=str& Mid(inputString, intCounter + 1,2) & ","
	Str2=str2& arrChars(intCounter) & ","
	Str3=str3& chr(arrChars(intCounter))
Next
wscript.echo "HEXA  : ["&str&"]"
wscript.echo "DEC   : ["&str2&"]"
wscript.echo "ASCII : ["&str3&"]"