'WScript.Echo "begin VBS"

' Get registry data that was piped in
RegData = ""
Do While Not WScript.StdIn.AtEndOfStream
    RegData = RegData & WScript.StdIn.ReadAll
Loop

' Remove any carriage returns
RegData = Replace(RegData, ChrW(13), "")

' Split into lines
RegLines = Split(RegData, ChrW(10))

' Sanity checking on data
If (RegLines(0) <> "") Or (RegLines(1) <> "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion") Then
    WScript.Echo "Got invalid header trying to run reg.exe"
    WScript.Quit(1)
End If

If Left(RegLines(2), 38) <> "    DigitalProductId    REG_BINARY    " Then
    WScript.Echo "Got invalid value list trying to run reg.exe"
    WScript.Quit(1)
End If

' Get hex string
HexString = Mid(RegLines(2), 39)
If (Len(HexString) Mod 2) <> 0 Then
    WScript.Echo "Got an odd number of hex digits in REG_BINARY data"
    WScript.Quit(1)
End If

' Convert to byte array
Dim ByteArray()
ReDim ByteArray((Len(HexString) / 2) - 1)  ' VBScript is just weird with array dimensions >.<

For i = 0 To (Len(HexString) - 2) Step 2
    ByteArray(i / 2) = CInt("&H" + Mid(HexString, i + 1, 2))
Next

Key = ConvertToKey(ByteArray)
WScript.Echo Key

' janek2012's magic decoding function
Function ConvertToKey(Key)
    Const KeyOffset = 52 ' Offset of the first byte of key in DigitalProductId - helps in loops
    isWin8 = (Key(66) \ 8) And 1 ' Check if it's Windows 8 here...
    Key(66) = (Key(66) And &HF7) Or ((isWin8 And 2) * 4) ' Replace 66 byte with logical result
    Chars = "BCDFGHJKMPQRTVWXY2346789" ' Characters used in Windows key
    ' Standard Base24 decoding...
    For i = 24 To 0 Step -1
        Cur = 0
        For X = 14 To 0 Step -1
            Cur = Cur * 256
            Cur = Key(X + KeyOffset) + Cur
            Key(X + KeyOffset) = (Cur \ 24)
            Cur = Cur Mod 24
        Next
        KeyOutput = Mid(Chars, Cur + 1, 1) & KeyOutput
        Last = Cur
    Next
    ' If it's Windows 8, put "N" in the right place
    If (isWin8 = 1) Then
        keypart1 = Mid(KeyOutput, 2, Cur)
        insert = "N"
        KeyOutput = keypart1 & insert & Mid(KeyOutput, Cur + 2)
    End If
    ' Divide keys to 5-character parts
    a = Mid(KeyOutput, 1, 5)
    b = Mid(KeyOutput, 6, 5)
    c = Mid(KeyOutput, 11, 5)
    d = Mid(KeyOutput, 16, 5)
    e = Mid(KeyOutput, 21, 5)
    ' And join them again adding dashes
    ConvertToKey = a & "-" & b & "-" & c & "-" & d & "-" & e
    ' The result of this function is now the actual product key
End Function