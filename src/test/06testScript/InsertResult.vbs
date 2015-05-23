'msgbox Wscript.Arguments(0)+Wscript.Arguments(1)+Wscript.Arguments(2)+Wscript.Arguments(3)+Wscript.Arguments(4)+Wscript.Arguments(5)+Wscript.Arguments(6)+Wscript.Arguments(7)+Wscript.Arguments(8)+Wscript.Arguments(9)
TestName=Wscript.Arguments(0)
ActionName =Wscript.Arguments(1)
No=Wscript.Arguments(2)
FieldName=Wscript.Arguments(3)
ActualValue=Wscript.Arguments(4)
ExpectedValue=Wscript.Arguments(5)
ExecuteStatus = Wscript.Arguments(6)
ExecuteDetails = Wscript.Arguments(7)
ReportFileName = Wscript.Arguments(8)
SheetName = Wscript.Arguments(9)
ReportFilePath=Wscript.Arguments(10)
ImageFilePath="reserved"

Call GenerateReport(TestName,ActionName,No,FieldName,ActualValue,ExpectedValue, ExecuteStatus, ExecuteDetails,ImageFilePath,ReportFileName,SheetName,ReportFilePath)


Function GenerateReport(TestName,ActionName,No,FieldName,ActualValue,ExpectedValue, ExecuteStatus, ExecuteDetails,ImageFilePath,ReportFileName,SheetName,ReportFilePath)
        'MSGBOX "TEST BEGIN"
        ReportFilePath=GetReportFilePath+ReportFilePath+ReportFileName
        ReportSheetName=SheetName
        SelectString="select * from "+" ["+ReportSheetName+"$]"  
        Set ReportedRow=ExecuteQuery(ReportFilePath,SelectString)  
        ReportedRowNum=ReportedRow.Recordcount  
        Set ReportedRow=Nothing  

    InsertString="Insert into "+"["+ReportSheetName+"$](TestId,ActionName,No,FieldName,ActualValue,ExpectedValue,ExecuteStatus, ExecuteDetails,ImageFilePath,ExecuteTime) Values('"+TestName+"','"+ActionName+"','"+No+"','"+FieldName+"','"+ActualValue+"','"+ExpectedValue+"','"+ExecuteStatus+"','"+ExecuteDetails+"','"+ImageFilePath+"','"+cstr(now)+"')"  
    'InsertString="Insert into "+"["+cstr(Environment("DefinedActionIteration"))+"$]"+"(TestName,ActionName) "+ "Values("+Environment("DefinedTestName")+","+Environment("DefinedActionName")+")"  

    Const AdUseClient=3  
    Set ObjectConnection=CreateObject("ADODB.Connection")  
    Set ObjectRecordSet=CreateObject("ADODB.RecordSet")
	
    'ObjectConnection.ConnectionString="Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};"&"DBQ="&ReportFilePath&";ReadOnly=False"
	    ObjectConnection.ConnectionString = "Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};" & _
                      "DBQ=" + ReportFilePath + ";" & _
                      "ReadOnly=false"
    ObjectConnection.Open    
    ObjectRecordSet.CursorLocation = adUseClient  
    ObjectRecordSet.Open SelectString,ObjectConnection,3,3  
    If Not ObjectRecordSet.EOF Then  
       ObjectRecordSet.MoveLast  
    End If  
      
'    ObjectRecordSet.execute InsertString  
    ObjectRecordSet.Close  
	'MSgbox InsertString
    ObjectRecordSet.Open InsertString,ObjectConnection,3,3  
'   ObjectRecordSet.Update  
        
    Set ObjectConnection=Nothing  
    Set ObjectRecordSet=Nothing      
         
End Function  


Function ExecuteQuery(QueryObjectFilePath, QueryString)   
    Const AdUseClient = 3
    Set ObjectConnection = CreateObject("ADODB.Connection")
    Set ObjectRecordSet = CreateObject("ADODB.RecordSet")
    'ObjectConnection.ConnectionString="Driver={Microsoft Excel Driver (*.xls)};"&"DBQ="&QueryObjectFilePath&";"&ReadOnly=False
    ObjectConnection.ConnectionString = "Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};" & _
                      "DBQ=" + QueryObjectFilePath + ";" & _
                      "ReadOnly=false"
    ObjectConnection.Open
    ObjectRecordSet.CursorLocation = AdUseClient
    ObjectRecordSet.Open QueryString, ObjectConnection, 3, 3
      
    Set ExecuteQuery = ObjectRecordSet
    Set ObjectConnection = Nothing
    Set ObjectRecordSet = Nothing
End Function



FUNCTION GetReportFilePath()
			Set wshShell = CreateObject("wscript.shell")
			RelativeFolder = wshShell.CurrentDirectory
			Num=ubound(split(RelativeFolder ,"\"))
			ParentFolder=split(RelativeFolder ,"\")(Num)
			msgPath = split(RelativeFolder ,ParentFolder)
			GetReportFilePath=msgPath(0)
			Set wshShell = Nothing
End FUNCTION