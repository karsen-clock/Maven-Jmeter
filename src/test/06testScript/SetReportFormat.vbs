
ReportFileName =Wscript.Arguments(0)
SheetName=Wscript.Arguments(1)
ReportFilePath=Wscript.Arguments(2)

call SetFormat(ReportFileName,SheetName,ReportFilePath)
FUNCTION SetFormat(ReportFileName,SheetName,ReportFilePath)
On Error Resume Next
Dim FileName, Text, ExcelApp, ExcelBook, ExcelSheet
FileName = GetReportFilePath+ReportFilePath+ReportFileName


Set ExcelApp = CreateObject("Excel.Application")
Set ExcelBook= ExcelApp.Workbooks.Open(FileName)
Set ExcelSheet = ExcelBook.Sheets.Item(SheetName)


' *************** 对文字的操作 ***************
 ExcelSheet.UsedRange.Font.Name = "Verdana"				'设置字体
ExcelSheet.Range("A1:J1").Font.Size = 12					'设置字号
ExcelSheet.usedRange.Font.Color = RGB(0, 0, 0)		'设置字体颜色
ExcelSheet.Range("A1:J1").Font.Bold = True					'文字加粗
ExcelSheet.Range("A1:J1").Font.Italic = True				'文字倾斜
ExcelSheet.Range("A1:J1").Interior.Color = RGB(255,255,0)

' *************** 对单元格的操作 ***************

ExcelSheet.usedRange.AutoFit					'自动调整列宽

ExcelSheet.usedRange.Rows.AutoFit					'自动调整行高

For i = 1 To ExcelSheet.UsedRange.Rows.Count
If ExcelSheet.UsedRange.Cells(i, 7) = "Passed" Then
    ExcelSheet.UsedRange.Cells(i, 7).Interior.Color = RGB(0, 255, 0)
    Elseif ExcelSheet.UsedRange.Cells(i, 7) = "Failed" THEN
    ExcelSheet.UsedRange.Cells(i, 7).Interior.Color = RGB(255, 0, 0)
    End If
Next


'ExcelSheet.Cells(10,2).HorizontalAlignment = 3		'设置水平对齐，1常规，2靠左，3居中，4靠右
													'	5填充，6两端对齐，7跨列居中，8分散对齐
'ExcelSheet.Cells(11,2).VerticalAlignment = 1		'设置垂直对齐，1靠上，2居中，3靠下
													'	4两端对齐，5分散对齐
ExcelSheet.usedRange.Borders.LineStyle=1		'设置左边框样式
REM ExcelSheet.usedRange.Borders(2).LineStyle=1		'设置右边框样式
REM ExcelSheet.usedRange.Borders(3).LineStyle=1		'设置上边框样式
REM ExcelSheet.usedRange.Borders(4).LineStyle=1		'设置下边框样式



ExcelBook.Save
ExcelBook.Close
ExcelApp.Quit
Set ExcelBook = Nothing
Set ExcelApp = Nothing  

'SystemUtil.CloseProcessByName "Excel.exe"		'如果仍有Excel.exe进程，可使用这句关闭进程

On Error GoTo 0
END FUNCTION


	   FUNCTION GetReportFilePath()
			Set wshShell = CreateObject("wscript.shell")
			RelativeFolder = wshShell.CurrentDirectory
			Num=ubound(split(RelativeFolder ,"\"))
			ParentFolder=split(RelativeFolder ,"\")(Num)
			msgPath = split(RelativeFolder ,ParentFolder)
			 GetReportFilePath=msgPath(0)
			Set wshShell = Nothing
	   end FUNCTION