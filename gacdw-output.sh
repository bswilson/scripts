# Parse the GACDW CSV output to just get production systems hostnames
#
# Field 30 = hostname
# Field 87 = production state

awk -F, '{print $30,$87}' GACDWQuery.csv |grep PRODUCTION >> whatever.csv
