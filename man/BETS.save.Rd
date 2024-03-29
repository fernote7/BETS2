% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BETS.save.R
\name{BETS.save}
\alias{BETS.save}
\title{Prepare a time series to be exported}
\usage{
BETS.save(code = NULL, data = NULL, file.name = "series", type = "")
}
\arguments{
\item{code}{An \code{integer}. The unique identifier of the series within the BETS database.}

\item{data}{A \code{data.frame} or a \code{ts}. Contains the data to be written. If \code{data} is supplied, the BETS database will not be searched.}

\item{file.name}{A \code{character}. The name of the output file. The default is 'series.spss'.}

\item{type}{A \code{character}. The type of the file (e.g. 'spss' or 'sas').}
}
\value{
A list with the data frame to be saved and the file name
}
\description{
To be used with BETS.save.spss, BETS.save.sas and others.
}

