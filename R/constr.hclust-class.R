## **************************************************************************
##
##    (c) 2018-2022 Guillaume Guénard
##        Department de sciences biologiques,
##        Université de Montréal
##        Montreal, QC, Canada
##
##    **constr.hclust class definition**
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
##    R source code file
##
## **************************************************************************
##
#' Class For Constrained Hiereachical Clustering
#' 
#' Files belonging to this class hold information about the constrained
#' agglomerative clustering and allows one to display results graphically.
#' 
#' @docType class
#' 
#' @name constr.hclust-class
#' 
#' @format A file belonging to this class is a list with elements:
#' \describe{
#' \item{merge}{A (n-1) by 2 matrix. Row i of file \code{"merge"} describes
#' the merging of clusters at step i of the clustering. If an element j in
#' the row is negative, it means that observation -j was merged at this
#' stage. If j is positive, it means that the merge was with the cluster
#' formed at the (earlier) stage j of the algorithm. Thus negative entries
#' in file \code{"merge"} indicate agglomerations of singletons, and
#' positive entries indicate agglomerations of non-singletons.}
#' 
#' \item{height}{A set of (n-1) non-decreasing real values. The clustering
#' height is the value of the criterion associated with the clustering
#' method for the particular agglomeration.}
#' 
#' \item{order}{A vector giving the permutation of the original observations
#' suitable for plotting, in the sense that a cluster plot using this ordering
#' and matrix merge will not have crossing branches.}
#' 
#' \item{labels}{Labels for the clustered objects.}
#' 
#' \item{method}{The agglomerative clustering method that has been used.}
#' 
#' \item{call}{The call that produced the result.}
#' 
#' \item{dist.method}{The distance that has been used to create dissimilarity
#' matrix \code{"d"} (only returned if the dissimilarity matrix object has a
#' "method" attribute attached to it).}
#' 
#' \item{links}{A copy of the list of edges (if a matrix of edges was provided
#' to the function).}
#' 
#' \item{coords}{A copy of the coordinates (if coordinates were provided to the
#' function).} }
#' 
#' @details The class inherits from \code{\link{hclust}-class} and describes the
#' tree produced by the constrained clustering procedure.
#' 
#' All class members except \code{links} and \code{coords} are identical to
#' those in \code{\link{hclust}-class}. several methods designed to process
#' these objects are expected to also work with \code{constr.hclust-class}
#' objects.
#' 
#' @seealso \code{\link{hclust}-class}
#' 
NULL
