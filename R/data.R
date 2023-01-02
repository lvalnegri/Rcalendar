#' @importFrom data.table data.table
NULL

#' calendar
#'
#' All days from 1st Jan 1970 until 31st Dec 2025 with some properties, characteristics and formattings.
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ dte }}{ the date in *standard* format `YYYY-MM-DD` }
#'   \item{\code{ is_weekday }}{ `Yes` for Mon-Fri, `No` for Sat and Sun }
#'   \item{\code{ is_workingday }}{ `No` for Sat and Sun plus *holidays* (as listed in the `holidays_uk` table), `Yes` for all the other days }
#'   \item{\code{ year }}{ Year }
#'   \item{\code{ fyear }}{ Financial Year (1st April to 31st March)  }
#'   \item{\code{ quarter }}{ Quarter (as Year + Quarter of the Year) }
#'   \item{\code{ qoy }}{ Quarter of the Year }
#'   \item{\code{ month }}{ Month (as Month of the Year in short form text + Year) }
#'   \item{\code{ moy }}{ Month of the Year }
#'   \item{\code{ moyt }}{ Month of the Year in text  }
#'   \item{\code{ moyts }}{ Month of the Year in short form text  }
#'   \item{\code{ moq }}{ Month of the Quarter }
#'   \item{\code{ week }}{ Week of the Year (as Year + `-W` + the number of the Week following ISO 8601) }
#'   \item{\code{ dweek }}{ Date of the Week of the Year (as the standard date of the Monday of the Week of the Year) }
#'   \item{\code{ woy }}{ Week of the Year (number only) }
#'   \item{\code{ woq }}{ Week of the Quarter }
#'   \item{\code{ wom }}{ Week of the Month }
#'   \item{\code{ doy }}{ Day of the Year }
#'   \item{\code{ doq }}{ Day of the Quarter }
#'   \item{\code{ dom }}{ Day of the Month }
#'   \item{\code{ dow }}{ Day of the Week (following ISO-8601, with Monday the first day of the Week)  }
#'   \item{\code{ dowt }}{ Day of the Week as text, an ordered factor with Monday as the first day of the Week }
#'   \item{\code{ dowts  }}{ Day of the Week as short text, an ordered factor with Monday as the first day of the Week }
#'   \item{\code{ rdow }}{ Gregorian Day of the Week (with Sunday the first day of the Week) }
#'   \item{\code{ rdowt }}{ Gregorian Day of the Week as text, an ordered factor with Sunday as the first day of the Week }
#'   \item{\code{ rdowts  }}{ Gregorian Day of the Week as short text, an ordered factor with Sunday as the first day of the Week }
#'   \item{\code{ mseason }}{ *Meteorological* Season (with the starting days being the first of the months: March, June, September, December) }
#'   \item{\code{ aseason }}{ *Astronomical* Season (as listed in the `seasons` table) }
#' }
#'
'calendar'

#' UK holidays
#'
#' A list of all UK Bank Holidays from 1970 to 2025
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ dte }}{ the date of the holiday in *standard* format `YYYY-MM-DD`}
#'   \item{\code{ name }}{ the name of the holiday }
#' }
#'
'uk_holidays'

#' Seasons
#'
#' Starting Day for the seasons of the year, from 1970 to 2050.
#' 
#' Based on the [600-Year NASA/JPL DE405 Ephemeris Model](https://neoprogrammics.com/equinoxes_and_solstices/Equinoxes_and_Solstices_Calculator.php)
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ year }}{ the year }
#'   \item{\code{ spring }}{ the starting day for Spring }
#'   \item{\code{ summer }}{ the starting day for Summer }
#'   \item{\code{ autumn }}{ the starting day for Autumn }
#'   \item{\code{ winter }}{ the starting day for Winter }
#' }
#'
'seasons'
