## **************************************************************************
##
##    (c) 2018-2022 Guillaume Guénard
##        Department de sciences biologiques,
##        Université de Montréal
##        Montreal, QC, Canada
##
##    **Data set: Old Faithful Erruption Interval**
##
##    This file is part of constr.hclust
##
##    constr.hclust is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    constr.hclust is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with constr.hclust. If not, see <https://www.gnu.org/licenses/>.
##
## /*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\
## |                                                            |
## |  CONSTRAINED HIERARCHICAL CLUSTERING                       |
## |  using (user-specified) criterion                          |
## |                                                            |
## |  C implementation of the Lance and Williams (1967) method  |
## |  for hierarchical clustering with or without the spatial   |
## |  contiguity constraint.                                    |
## |                                                            |
## \-----------------------------------------------------------*/
##
##    R source code file
##
## **************************************************************************
## 
#' Old Faithful Erruption Interval Data Set
#' 
#' Erruption intervals during a time period of approximately eleven years
#' 
#' @docType data
#' 
#' @keywords Geyser
#' 
#' @name Faithful
#' 
#' @usage data(Faithful)
#' 
#' @format A two-column data frame:
#' \describe{
#' \item{Interval}{Mean time interval, in hours, between two consecutive
#' erruptions.}
#' \item{Date}{Median POSIX time of the averaging window (see below).}
#' }
#' 
#' @details Erruption timing data of Old Faithful geyser (Yellowstone National
#' Park, WY, USA) between 2000 and 2011 were downloaded from website
#' http://www.geyserstudy.org (access time: Sun Dec 13 14:43:25 2020). The
#' original data series had 58527 eruption times and showed discontinuities
#' because of interruptions in data recording (caused by equipment malfunction,
#' maintenance, or onboard computer memory overrun caused by harsh weather
#' conditions interferring with satelite data transmission. The series was thus
#' split into 20 segments with continuous observations and the intervals between
#' the eruptions were calculated for each of them.
#' 
#' For exemplary purposes, the segments were decimated to a smaller size by
#' averaging individual time intervals using a 50-eruption wide Hann window and
#' then the decimated data segments were concatenated into a single data series
#' of 1142 estimates of the mean eruption interval.
#' 
#' @seealso related data set \code{\link{faithful}} in
#' \code{\link{datasets-package}} and \code{geyser} from package
#' \code{MASS}.
#' 
#' @source Guillaume Guenard <guillaume.guenard@gmail.com> and, Pierre Legendre
#' <pierre.legendre@@umontreal.ca>; http://www.geyserstudy.org
#' 
#' @examples data(Faithful)
#' 
#' ## Distance matrix (Euclidean) of the mean intervals:
#' 
#' dst <- dist(Faithful$Interval)
#' 
#' ## Segmenting the series with respect to eruption time intervals using
#' ## chronological clustering (time-constrained Lance-Williams hierarchical
#' ## agglomerative clustering):
#' 
#' chcl <- constr.hclust(dst, coords = Faithful$Date, chron = TRUE)
#' 
#' ### Plotting the results:
#' 
#' ## Partition sizes and the colors to display them:
#' parts <- c(2,3,4,5,6,7)
#' cols <- list(
#'   c("red","purple"),
#'   c("red","blue","purple"),
#'   c("red","orange","blue","purple"),
#'   c("red","orange","yellow","blue","purple"),
#'   c("red","orange","yellow","green","blue","purple"),
#'   c("red","orange","yellow","green","aquamarine","blue","purple")
#' )
#' 
#' ## Plotting partitions with 2-7 segments:
#' par(mar=c(5,6.5,2,2))
#' plot(x=range(Faithful$Date), y=c(0.5,6.5), type="n", xlab="Time",
#'      ylab="Partitions\n\n", yaxt="n")
#' for(i in 1L:length(parts)) {
#'   chcl$coords[,"y"] <- i
#'   plot(chcl, parts[i], link=TRUE, lwd=25, hybrids="none",
#'        lwd.pt=0.5, cex=0, pch=21, plot=FALSE, lend=2, col=cols[[i]])
#' }
#' axis(2, at=1:length(parts), labels=sprintf("%d groups",parts), las=1)
#' 
#' tmp <- which(!!diff(cutree(chcl,parts[i])))
#' data.frame(From=Faithful$Date[tmp],
#'            To=Faithful$Date[tmp+1])
#' 
NULL
