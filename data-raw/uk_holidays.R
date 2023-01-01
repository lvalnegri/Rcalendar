Rfuns::load_pkgs('data.table', 'rvest')

yh <- data.table()
for(yr in 1970:2025){
    message('Processing ', yr)
    y <- read_html(paste0('https://www.ukbankholidays.co.uk/year/', yr)) |> 
            html_elements('.calendar-items-list li , .calendar-items-list a') |> 
            html_text()
    y <- data.table( y[seq(1, length(y), 2)], y[seq(2, length(y), 2)] )
    y[, c('dte', 'name') := tstrsplit(V1, ' - ')]
    y <- rbind(y[!grepl('Ireland|Scotland|Wales', name)], y[grepl('England', name)])
    yh <- rbindlist(list( yh, y[, .(date, name = V2)]))
    Sys.sleep(2)
}
yh <- yh[!grepl('Father|Mother|David|Fawkes|George|Valentine|Halloween', yh$name)]
yh[name == "New Year's Day" & mday(dte) > 1, name := "Substitute day for New Year's Day"]
yh <- rbind(yh, data.table(dte = '09-09-2022', name = 'Bank Holiday for the State Funeral of Queen Elizabeth II'))
yh[, date := as.Date(date, '%d-%m-%Y')]
setorder(yh, 'dte')
save_dts_pkg(yh, 'uk_holidays', dbn = 'calendar')
