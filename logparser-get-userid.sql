REM### logparser_get_userid.bat
REM### by Scott Wilson, bswilson@us.ibm.com
REM### Find all event for a given userid and place them in an output file called output.csv,
REM### which is sorted by time and date.

REM### Substitute 'userid_goes_here' with the userid you are interested in.

"C:\Program Files (x86)\Log Parser 2.2\LogParser.exe" -i:EVT "SELECT TimeGenerated,EventID,EventType,EventTypeName,EventCategory,EventCategoryName,SourceName,Strings,ComputerName,SID,Message FROM S:\SECURITY\IN12607784-2\*.evt WHERE Message like '%userid_goes_here%' ORDER BY TimeGenerated DESC" -o:CSV -q:ON -stats:OFF >> output.csv
