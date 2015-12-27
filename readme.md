##SQL Date functions##
A couple date functions written for SQL-Server (although could be easily ported to other platforms).

###Holiday_list()###

This function returns a table of "holidays" for any given year. Rather than build a table of holidays and update it each year, this UDF stores holiday rules as procedural logic and computes the holidays of any year...

To use the function, you should first review the code and comment out any holidays you might not want to include, or possibly add any additional holidays. There are three "rules" for computing holidays dates.

*Fixed date holiday-Holidays which fall on the same "date" each year (such as Christmas or April Fool's day)

*Fixed day holidays-Holidays which fall on the X day of the week of the Y week of the month (such as Thanksgiving or labor day)

*Easter holidays-Holidays that are relative to the date of Easter Sunday (Good Friday, Palm Sunday, etc.)

Once the function contains your set of holidays, you can use the function just as you would a normal SQL table. 

###DateToEnglish###
This function takes a date/time value and converts it to a more common English word, such as tomorrow, yesterday, last Tuesday, etc. 

If it can't convert it, it simply returns a formatted date.

[Joe Booth Consulting] (http://www.joebooth-consulting.com)
