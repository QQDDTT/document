```vb
Sub SearchAndCatch()
    Call CleanCellsByColor(Sheet1.Name, 6)
    Dim VrtSelectedItem As Variant
    Dim superPath As String
    With Application.FileDialog(msoFileDialogFolderPicker)
        If .Show = -1 Then
            For Each VrtSelectedItem In .SelectedItems
                superPath = VrtSelectedItem
                'SuperFolder insert
                Call WriteCellUnderText(Sheet1.Name, 1, "ProjectPath", superPath)
                Call WriteCellUnderText(Sheet1.Name, 1, "LogPath", superPath)
            Next VrtSelectedItem
        Else
        End If
    End With
    Call CatchFileByType(superPath, Sheet1.Cells(3, 1))
End Sub
```

```vb
Function CatchFileByType(path, fileType)
    Dim fso As Object
    Dim fd As Object
    Dim f1 As Object
    Dim f2 As Object
    Set fso = New FileSystemObject
    Set fd = fso.GetFolder(path)
    For Each f1 In fd.Files
        If f1.Name Like fileType Then
            'SubFile
            Call PutCellUnderText(Sheet1.Name, 1, "FilesList", path & "\" & f1.Name & ";")
        End If
    Next
    For Each f2 In fd.SubFolders
        Call CatchFileByType(path & "\" & f2.Name, fileType)
    Next
End Function
```





```vb
Function WriteCellUnderText(sheetName, column, keyText, valueText)
    For i = 1 To ThisWorkbook.Sheets(sheetName).Cells(rows.Count, column).End(xlUp).row
        If Sheets(sheetName).Cells(i, column) = keyText Then
            Sheets(sheetName).Cells(i + 1, column) = valueText
        End If
    Next
End Function
```

```vb
Function PutCellUnderText(sheetName, column, keyText, valueText)
    ThisWorkbook.Sheets(sheetName).Cells(Sheets(sheetName).Cells(rows.Count, column).End(xlUp).row + 1, column) = valueText
End Function
```



```vb
Function OutputLogFile()
    'Create Log Path
    Dim logPath As String
    logPath = ThisWorkbook.path & "\fileControlFactoryLog_" & Format(Now, "yyyy_mm_dd_mm_ss") & ".log"
    Call WriteCellUnderText(Sheet1.Name, 1, "LogPath", logPath)
    'Create Log File
    Call CreateFile(logPath, 0)
End Function
```



```vb
Function CreateFile(path, columnNum)
    Sheet2.Calculate
    Dim text As String
    text = ""
    If columnNum <> 0 Then
        For i = 2 To Sheet2.Cells(rows.Count, columnNum).End(xlUp).row
            text = text & Sheet2.Cells(i, columnNum) & vbCrLf
        Next
    Else
        text = "FILE CONTROL FACTORY LOG"
    End If
    Open path For Output As #1
    Print #1, text
    Close #1
End Function
```


```vb
Sub open_sakura()
    Dim path As String
    path = """C:\Program Files (x86)\sakura\sakura.exe"""
    Call open_exe(path)
End Sub
```



```vb
Function open_exe(path As String)
    Dim wsh As New WshShell
    Dim lngReturn As Long
    lngReturn = wsh.Run(path, 1, False)
    wsh.Popup lngReturn, 5, "Information", vbOKOnly
    Set wsh = Nothing
End Function

```