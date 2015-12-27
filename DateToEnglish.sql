---------------------------------------------------------------------------------------------------------------
-- DateToEnglish
-- Converts a date/time value to a more common English word, such as tomorrow, yesterday, last Tuesday, etc.
---------------------------------------------------------------------------------------------------------------
create function dbo.DateToEnglish(@theDate DATETIME,@CountryCode varchar(3))
returns varchar(32)
as
begin
	-- Function to convert a date value to a more conversational
	-- English equivalent, such as today, yesterday, next Monday, etc.
	declare @ans		VARCHAR(32)
	declare @today		DATETIME
	declare @nDiff		INT
	declare @weekday	INT
	
	SET @today = getDate()
	-- How many dates away from current date	
	SET @nDiff = DateDiff(d,@today,@theDate)	
	-- Easiest ones, yesterday, today, and tomorrow
	IF abs(@nDiff) <=1 
	begin
		select @ans = 
			case @nDiff
			when -1	then 'yesterday'
			when 0 then  'today'
			when 1 then  'tomorrow'
			end 
		return @ans	
	end
	-- Day of week	(1=Sun,7=Sat)	
	SET @ans=''
	SET @weekday = datepart(dw,getDate())					
	IF abs(@nDiff) < 7
	begin
		SET @weekDay = @WeekDay +@nDiff
		IF @WeekDay >7 SET @weekday = @weekday-7
		IF @WeekDay <1 SET @weekday = @weekday+7		
		SET @ans = rtrim(substring('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ',((@weekDay-1)*9)+1,9))
		if @nDiff < 0 set @ans = 'Last '+@ans
	end
	-- Anything else, just create a default date format
	if @ans = ''
	begin
			set @ans = convert(varchar(32),@theDate,107)
	end
	return @ans
end
go
select dbo.dateToEnglish( getDate() )						-- Should return "today"
select dbo.dateToEnglish( dateAdd(d,-1,getDate()) )			-- Should return "yesterday"
select dbo.dateToEnglish( dateAdd(d,+1,getDate()) )			-- Should return "tomorrow"
select dbo.dateToEnglish( dateAdd(d,+2,getDate()) )			-- Should return "sunday"
select dbo.dateToEnglish( dateAdd(d,+3,getDate()) )			-- Should return "monday"
select dbo.dateToEnglish( dateAdd(d,+4,getDate()) )			-- Should return "tuesday"
select dbo.dateToEnglish( dateAdd(d,-3,getDate()) )			-- Should return "last tuesday"

select dbo.dateToEnglish( dateAdd(d,+32,getDate()) )		

