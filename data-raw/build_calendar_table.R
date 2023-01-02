Rfuns::load_pkgs('data.table')

start_date <- as.IDate('1970-01-01')
end_date <- as.IDate('2025-12-31')
cs <- seq(start_date, end_date, 1)

cal <- data.table( dte = cs )

message('Adding year (YYYY)...')
cal[, year := year(dte)]

message('Adding quarter of year ([Q]x)...')
cal[, qoy := factor(quarters(dte), ordered = TRUE)]

message('Adding quarter (YYYY [Q]x)...')
ord_qrtrs <- sort(apply( expand.grid(year(start_date):year(end_date), 1:4), 1, function(x) paste(x, collapse = ' Q') ))
cal[, quarter := factor(paste(year, qoy), levels = ord_qrtrs, ordered = TRUE)]

message('Adding week of quarter (1:13) and day of quarter (1:92)...')
cal[, doq := 1:.N, quarter][, woq := floor((doq - 1) / 7) + 1 ]

message('Adding month of year in long char format (MMMM), short char formats (MM), numeric format (1:12)...')
cal[, `:=`( 
    moyt = factor(months(dte), levels = month.name, ordered = TRUE), 
    moyts = factor(substr(months(dte), 1, 3), levels = month.abb, ordered = TRUE),
    moy = month(dte)
)]

message('Adding month (MM YYYY)...')
ord_months <- apply( expand.grid(month.abb, year(start_date):year(end_date)), 1, function(x) paste(x, collapse = ' ') )
cal[, month := factor(paste(moyts, year), levels = ord_months, ordered = TRUE)]

message('Adding month of quarter (1:3)...')
cal[, moq := ifelse(moy %in% c(1, 4, 7, 10), 1, ifelse(moy %in% c(2, 5, 8, 11), 2, 3))]

message('Adding financial year ([FY]YY)...')
calc_fyear <- Vectorize( function(x, y) paste0('FY-', ifelse(x <= 3, substr(y - 1, 3, 4), substr(y, 3, 4) ) ) )
cal[, fyear := factor(calc_fyear(moy, year), ordered = TRUE)]

message('Adding week of year (1:53) and week of month (1:5)...')
cal[, `:=`( woy = lubridate::week(dte), wom = floor( (mday(dte) - 1) / 7) + 1 )]

message('Adding week (YYYY-[W]01:52) and Monday start date of the week (YYYY-MM-DD)...')
cal[, week := factor(ISOweek::ISOweek(dte), ordered = TRUE)][, dweek := ISOweek::ISOweek2date(paste0(week, '-1'))]

message('Adding day of week (1:7), month (1:31), and year (1:366)...')
cal[, `:=`( gdow = wday(dte), dom = mday(dte), doy = yday(dte))]

message('Adding day of week in long (DDDD) and short (DD) char formats...')
ord_days <- c('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')
cal[, gdowt := factor(weekdays(dte), levels = ord_days, ordered = TRUE)]
cal[, gdowts := factor(substr(gdowt, 1, 3), levels = substr(ord_days, 1, 3), ordered = TRUE)]
ord_days <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')
cal[, dow := sapply(gdowt, \(x) which(x == ord_days))]
cal[, dowt := factor(weekdays(dte), levels = ord_days, ordered = TRUE)]
cal[, dowts := factor(substr(dowt, 1, 3), levels = substr(ord_days, 1, 3), ordered = TRUE)]

message('Adding seasons...')
cal[, mseason := 'Winter']
cal[moy %in% 3:5, mseason := 'Spring']
cal[moy %in% 6:8, mseason := 'Summer']
cal[moy %in% 9:11, mseason := 'Autumn']
ys <- fread('./data-raw/csv/seasons.csv')
save_dts_pkg(ys, 'seasons', dbn = 'calendar')
cal[, season := mseason]
for(yr in year(start_date):year(end_date)){
    cal[year == yr & moy == 3 & dom < ys[year == yr, winter], season := 'Winter']
    cal[year == yr & moy == 6 & dom < ys[year == yr, spring], season := 'Spring']
    cal[year == yr & moy == 9 & dom < ys[year == yr, summer], season := 'Summer']
    cal[year == yr & moy == 12 & dom < ys[year == yr, autumn], season := 'Autumn']
}

message('Adding weekdays and working days...')
cal[, is_weekday := 'Yes'][dow %in% 6:7, is_weekday := 'No']
cal[, is_workingday := is_weekday]
yh <- fread('./data-raw/csv/uk_holidays.csv')
cal[dte %in% yh$dte, is_workingday := 'No']

message('Converting categorical into factors...')
cols <- c('season', 'mseason', 'is_weekday','is_workingday')
cal[, (cols) := lapply(.SD, as.factor), .SDcols = cols]

message('Changing order to columns...')
setcolorder(cal, c(
    'dte', 'is_weekday', 'is_workingday', 'year', 'fyear', 'quarter', 'qoy', 'month', 'moy', 'moyt', 'moyts', 'moq',
    'week', 'dweek', 'woy', 'woq', 'wom', 'doy', 'doq', 'dom', 'dow', 'dowt', 'dowts', 'gdow', 'gdowt', 'gdowts',
    'season', 'mseason'
))
save_dts_pkg(cal, 'calendar', dbn = 'calendar')

rm(list = ls())
gc() 