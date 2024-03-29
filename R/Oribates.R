## **************************************************************************
##
##    (c) 2018-2022 Guillaume Guénard
##        Department de sciences biologiques,
##        Université de Montréal
##        Montreal, QC, Canada
##
##    **Data set: Borcard's Obitatid Mite**
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
#' Borcard's Obitatid Mite Data Set
#'
#' Oribatid mite community data in a peat bog surrounding Lac Geai, QC, Canada
#'
#' @docType data
#' 
#' @keywords mite
#' 
#' @name Oribates
#' 
#' @usage data(Oribates)
#' 
#' @format A list with six elements:
#' \describe{
#' \item{fau}{ A data frame with 70 rows (sites) and 35 columns (species) whose
#' contents are the abundances of the species in the sites. }
#' \item{env}{ A data frame with 70 rows (sites) and five columns (variables)
#' whose contents are environmental variables taken on the sites. }
#' \item{xy}{ Cartesian coordinates of the sites in the study area. }
#' \item{link}{ A list of edges between neighboring locations (see details). }
#' \item{topo}{ A list of color values for representing the topography of the
#' study area. }
#' \item{map}{ A raw color raster of the topography of the study area. }
#' }
#' 
#' @details Variables of \code{oribatid$env} are:
#' \describe{
#' \item{SubsDens}{ Substrate density (g/L). }
#' \item{WatrCont}{ Water content of the peat (g/L) }
#' \item{Substrate}{ A seven-level factor describing the substrate (more on
#' that subject below. }
#' \item{Shrub}{ A three-level factor describing the presence and abundance of
#' shrubs (mainly Ericaceae ) on the peat surface. }
#' \item{topo}{ A two-level factor describing the microtopography of the peat
#' mat. }}
#' 
#' Levels of \code{oribatid$env$Substrate} are described as follows:
#' \describe{
#' \item{Sphagn1}{ Sphagnum magellanicum (with a majority of S. rubellum). }
#' \item{Sphagn2}{ Sphagnum rubellum. }
#' \item{Sphagn3}{ Sphagnum nemoreum (with a minority of S. angustifolium). }
#' \item{Sphagn4}{ Sphagnum rubellum and S. magellanicum in equal parts. }
#' \item{Litter}{ Ligneous litter. }
#' \item{Barepeat}{ Bare peat. }
#' \item{Interface}{ Interface between Sphagnum species. }}
#' 
#' Levels of \code{oribatid$env$Shrub} where: "none", "few", and "many" (the
#' variable may also be considered semi-quantitative), whereas levels of
#' \code{oribatid$env$topo} were "Blanket" (ie. flat) and "Hummock"
#' (ie. raised).
#' 
#' \code{Oribates$map} is a color raster generated from Fig. 1 in Borcard et al.
#' 1994. It has dimensions 244 (number of pixels along the Y axis) by 940
#' (number of pixels along the X axis) and describes an area of 2.6m (Y axis) by
#' 10m (W axis) with a resolution of approximately 10.6mm per pixel. A higher
#' resolution image from the same data can also be found as Fig. 1.1 in Borcard
#' et al. 2018 (see references below). The X axis corresponds to locations going
#' from the edge of the water to the edge of the forest. The Y axis correspond
#' the distances along the lake's shore.
#' 
#' @seealso Data set \code{oribatid} from package \code{ade4}, which is another
#' version of this data set.
#'
#' @author Daniel Borcard, <daniel.borcard@@umontreal.ca> and Pierre Legendre
#' <pierre.legendre@@umontreal.ca>
#' 
#' @references
#' Borcard, D. and Legendre, P. 1994. Environmental Control and Spatial
#' Structure in Ecological Communities: An Example Using Oribatid Mites
#' (Acari, Oribatei). Environ. Ecol. Stat. 1(1): 37-61 \doi{10.1007/BF00714196}
#' 
#' Borcard, D., Legendre, P., and Drapeau, P. 1992. Partialling out the spatial
#' component of ecological variation. Ecology, 73, 1045-1055.
#' \doi{10.2307/1940179}
#' 
#' Borcard, D.; Legendre, P.; and Gillet, F. 2018. Numerical Ecology with R
#' (2nd Edition) Sprigner, Cham, Switzerland. \doi{10.1007/978-3-319-71404-2}
#' 
#' @examples data("Oribates",package="constr.hclust")
#' 
#' ## A map of the study area with the links.
#' par(mar=rep(0,4L))
#' plot(NA,xlim=c(0,12),ylim=c(-0.1,2.5),yaxs="i",asp=1,axes=FALSE)
#' rasterImage(Oribates$map, 0, -0.1, 10, 2.5, interpolate=FALSE)
#' arrows(x0=0.15,x1=1.15,y0=0.1,y1=0.1,code=3,length=0.05,angle=90,lwd=2)
#' text(x=0.65,y=0.025,labels="1m")
#' invisible(
#'   apply(Oribates$link,1L,
#'         function(x,xy,labels) {
#'           segments(x0=xy[x[1L],1L],x1=xy[x[2L],1L],
#'                    y0=xy[x[1L],2L],y1=xy[x[2L],2L])
#'         },xy=Oribates$xy,labels=FALSE)
#' )
#' points(Oribates$xy,cex=1.25,pch=21,bg="black")
#' legend(10.1,2.5,legend=Oribates$topo[["Type"]],pt.bg=Oribates$topo[["RGB"]],
#'        pch=22L,pt.cex=2.5)
#' 
#' ## Hellinger distance on the species composition matrix.
#' Oribates.hel <- dist(sqrt(Oribates$fau/rowSums(Oribates$fau)))
#' 
#' ## Constrained clustering of the sites on the basis of their species
#' ## composition.
#' Oribates.chclust <- constr.hclust(d=Oribates.hel, links=Oribates$link,
#'                                   coords=Oribates$xy)
#' 
#' ## Plotting with different numbers of clusters.
#' par(mfrow=c(4,1),mar=c(0.5,0,0.5,0))
#' cols <- c("turquoise", "orange", "blue", "violet", "green", "red", "purple")
#' parts <- c(2,3,5,7)
#' for(i in 1L:length(parts)) {
#'   plot(NA, xlim=c(0,10), ylim=c(-0.1,2.5), xaxs="i", yaxs="i", asp=1,
#'        axes=FALSE)
#'   arrows(x0=0.15, x1=1.15, y0=0.1, y1=0.1, code=3, length=0.05, angle=90,
#'          lwd=2)
#'   text(x=0.65, y=0, labels="1m", cex=1.5)
#'   plot(Oribates.chclust, parts[i], links=TRUE, plot=FALSE,
#'        col=cols[round(seq(1,length(cols),length.out=parts[i]))], lwd=4,
#'        cex=2.5, pch=21, hybrids="single", lwd.hyb=0.25, lty.hyb=3)
#'   text(x=0.25, y=2.25, labels=LETTERS[i], cex=2.5)
#' }
#' 
NULL
##
