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
yh[, date := as.Date(date, '%d-%m-%Y')]
setorder(yh, 'dte')
save_dts_pkg(yh, 'uk_holidays', dbn = 'calendar')
