#' @importFrom data.table data.table
NULL

#' calendar
#'
#' Description ...
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ dte }}{ the date in *standard* format `YYYY-MM-DD` }
#'   \item{\code{ is_weekday }}{  }
#'   \item{\code{ is_workingday }}{  }
#'   \item{\code{ year }}{  }
#'   \item{\code{ fyear }}{   }
#'   \item{\code{ quarter }}{   }
#'   \item{\code{ qoy }}{  }
#'   \item{\code{ month }}{  }
#'   \item{\code{ moy }}{  }
#'   \item{\code{ moyt }}{  }
#'   \item{\code{ moyts }}{  }
#'   \item{\code{ moq }}{  }
#'   \item{\code{ week }}{  }
#'   \item{\code{ dweek }}{  }
#'   \item{\code{ woy }}{  }
#'   \item{\code{ woq }}{  }
#'   \item{\code{ wom }}{  }
#'   \item{\code{ doy }}{  }
#'   \item{\code{ doq }}{  }
#'   \item{\code{ dom }}{  }
#'   \item{\code{ dow }}{ Day of the Week (following ISO-8601 with Monday the first day)  }
#'   \item{\code{ dowt }}{ Day of the Week as text, an ordered factor with Monday as the first day }
#'   \item{\code{ dowts  }}{ Day of the Week as short text, an ordered factor with Monday as the first day }
#'   \item{\code{ rdow }}{ Day of the Week (following most religions with Sunday the first day) }
#'   \item{\code{ rdowt }}{ Day of the Week as text, an ordered factor with Sunday as the first day }
#'   \item{\code{ rdowts  }}{ Day of the Week as short text, an ordered factor with Sunday as the first day }
#'   \item{\code{ mseason }}{ *Meteorological* Season: the starts are the first of the months: March, June, September, December }
#'   \item{\code{ aseason }}{ *Astronomical* Season: the starts are: 20th March, 21th June, 23th September, 21th December }
#' }
#'
'calendar'

#' UK holidays
#'
#' A list of all UK Bank Holidays from 1970 to 2025
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ dte }}{ the date }
#'   \item{\code{ name }}{  the name of the holiday }
#' }
#'
'uk_holidays'