REM### logparser_get_events.bat
REM### by Scott Wilson, bswilson@us.ibm.com
REM### Grab all System Event ID 20142 events (RAS connects) from the Event Viewer, and place
REM### them into a date-sorted CSV file called "foo.csv": 
REM### Example -- LogParser.exe -i:CSV "SELECT TimeGenerated, EventID FROM System WHERE 
REM### EventID=20142" > foo.csv 

"C:\Program Files\Log Parser 2.2\LogParser.exe" -i:EVT "SELECT TimeGenerated, Count (*) FROM System WHERE EventID=6001 GROUP BY date" -o:CSV > foo.csv

REM### Other examples

REM login events
LogParser.exe -i:evt -o:csv "SELECT * INTO C:\temp\foo.csv FROM C:\temp\*.evt WHERE EventID=4624"

REM cleared the log
LogParser.exe -i:evt -o:csv "SELECT * INTO C:\temp\cleared-log.csv FROM C:\temp\*.evt WHERE EventID=1102"




select *
from C:\temp\*.evt
where date = %date%
where EventID = 
