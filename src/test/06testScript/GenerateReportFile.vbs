
ReportFileName =Wscript.Arguments(0)
SheetName=Wscript.Arguments(1)
ReportFileRegularPath=Wscript.Arguments(2)	 
		 
		 
		 call GenerateReportFile(ReportFileName,SheetName,ReportFileRegularPath)
         Function GenerateReportFile(ReportFileName,SheetName,ReportFileRegularPath)
				
		 Set fso=CreateObject("Scripting.FileSystemObject")

	     ReportPath=GetReportFilePath
		
         ReportFilePath=ReportPath+ReportFileRegularPath&ReportFileName
		 
 
          If fso.FileExists(ReportFilePath) Then'ÅÐ¶ÏÎÄ¼þ´æÔÚ
             
             exit function
             end If
         Set fso=Nothing
          
         set  ExcelObject=CreateObject("Excel.Application")
    	  
               	   ExcelObject.Workbooks.Add
                   ExcelObject.ActiveSheet.Name=sheetName
                   With ExcelObject.Sheets(sheetName)      
                   .Range("A1")="TestId"
                   .Range("B1")="ActionName"
				   .Range("C1")="No"
				   .Range("D1")="FieldName"
				   .Range("E1")="ActualValue"
				   .Range("F1")="ExpectedValue"
				   .Range("G1")="ExecuteStatus"
                   .Range("H1")="ExecuteDetails"
                   .Range("I1")="ImageFilePath"
                   .Range("J1")="ExecuteTime"  
                  End With        
				  
				       
	               ExcelObject.ActiveWorkbook.SaveAs ReportFilePath
				   
	      'ExcelObject.Workbooks.Open(ReportFilePath)
          REM With ExcelObject.Sheets("test")
           REM .Range("A1")="TestName"
                   REM .Range("A1")="TestName"
                   REM .Range("B1")="ActionName"
				   REM .Range("C1")="ExpectedValue"
				   REM .Range("D1")="ActualValue"
				   REM .Range("E1")="ExecuteStatus"
                   REM .Range("F1")="ExecuteDetails"
                   REM .Range("G1")="ImageFilePath"
                   REM .Range("H1")="ExecuteTime"   
          REM End With
          ' ExcelObject.ActiveWorkbook.Save     
         ExcelObject.Workbooks.Close
        ExcelObject.Application.Quit
        ExcelObject.Quit
        Set ExcelObject=Nothing 
	'msgbox "finished"
       end Function
	   
	   FUNCTION GetReportFilePath()
			Set wshShell = CreateObject("wscript.shell")
			RelativeFolder = wshShell.CurrentDirectory
			Num=ubound(split(RelativeFolder ,"\"))
			ParentFolder=split(RelativeFolder ,"\")(Num)
			msgPath = split(RelativeFolder ,ParentFolder)
			 GetReportFilePath=msgPath(0)
			Set wshShell = Nothing
	   end FUNCTION