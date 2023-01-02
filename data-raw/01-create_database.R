###############################################
# Create databases and tables in MySQL server #
###############################################

library(Rfuns)

dbn <- 'calendar'
dd_create_db(dbn)

## CALENDAR -------
x <- "
    dte DATE NOT NULL,
    is_weekday CHAR(3) NOT NULL,
    is_workingday CHAR(3) NOT NULL,
    year SMALLINT(4) UNSIGNED NOT NULL,
    fyear CHAR(6) NOT NULL,
    quarter CHAR(7) NOT NULL,
    qoy CHAR(2) NOT NULL,
    month CHAR(8) NOT NULL,
    moy TINYINT(2) UNSIGNED NOT NULL,
    moyt CHAR(9) NOT NULL,
    moyts CHAR(3) NOT NULL,
    moq TINYINT(1) UNSIGNED NOT NULL,
    week CHAR(8) NOT NULL,
    dweek DATE NOT NULL,
    woy TINYINT(2) UNSIGNED NOT NULL,
    woq TINYINT(2) UNSIGNED NOT NULL,
    wom TINYINT(1) UNSIGNED NOT NULL,
    doy SMALLINT(3) UNSIGNED NOT NULL,
    doq TINYINT(2) UNSIGNED NOT NULL,
    dom TINYINT(2) UNSIGNED NOT NULL,
    dow TINYINT(1) UNSIGNED NOT NULL,
    dowt CHAR(9) NOT NULL,
    dowts CHAR(3) NOT NULL,
    gdow TINYINT(1) UNSIGNED NOT NULL,
    gdowt CHAR(9) NOT NULL,
    gdowts CHAR(3) NOT NULL,
    season CHAR(7) NOT NULL,
    mseason CHAR(7) NOT NULL,
    PRIMARY KEY (dte),
    INDEX(is_weekday),
    INDEX(is_workingday),
    INDEX(year),
    INDEX(fyear),
    INDEX(quarter),
    INDEX(qoy),
    INDEX(month),
    INDEX(moy),
    INDEX(moyt),
    INDEX(moyts),
    INDEX(moq),
    INDEX(week),
    INDEX(dweek),
    INDEX(woy),
    INDEX(woq),
    INDEX(wom),
    INDEX(doy),
    INDEX(doq),
    INDEX(dom),
    INDEX(dow),
    INDEX(dowt),
    INDEX(dowts),
    INDEX(gdow),
    INDEX(gdowt),
    INDEX(gdowts),
    INDEX(season),
    INDEX(mseason)
"
dd_create_dbtable('calendar', dbn, x)

## UK_HOLIDAYS ----
x <- "
    `dte` DATE NOT NULL,
    `name` CHAR(60) NOT NULL,
    PRIMARY KEY (`dte`)
"
dd_create_dbtable('uk_holidays', dbn, x)

## SEASONS ----
x <- "
    `year` SMALLINT(4) UNSIGNED NOT NULL,
    `spring` TINYINT(2) UNSIGNED NOT NULL,
    `summer` TINYINT(2) UNSIGNED NOT NULL,
    `autumn` TINYINT(2) UNSIGNED NOT NULL,
    `winter` TINYINT(2) UNSIGNED NOT NULL,
    PRIMARY KEY (`year`)
"
dd_create_dbtable('seasons', dbn, x)


## END ------------
rm(list = ls())
gc()
