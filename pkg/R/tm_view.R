#' Options for the interactive tmap viewer
#' 
#' Set the options for the interactive tmap viewer. Some of these options can also be set with \code{\link{tm_layout}}, since they are style dependent (e.g., the choice of basemaps). The function \code{tm_view} overrides these options when specified.
#' 
#' @param alpha transparency (opacity) parameter applied to whole map. By default, it is set to \code{0.7} if basemaps are used, and \code{1} otherwise.  
#' @param colorNA default color for missing values (that is, in case \code{colorNA} is unspecified in layer functions such as \code{\link{tm_fill}}). The default value of \code{NULL} means transparent. It overrides the \code{na} value of the \code{aes.color} in \code{\link{tm_layout}}.
#' @param basemaps vector of one or more names of baselayer maps, or a logical value. See \url{http://leaflet-extras.github.io/leaflet-providers/preview}. Also supports URL's for tile servers, such as \code{"http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"}. By default (\code{NA}), the choice of basemap(s) will be determined by the \code{basemaps} argument of \code{\link{tm_layout}}, which is style dependent. Use \code{TRUE} to select a large set of recommended basemaps. Use \code{FALSE} to omit basemap tiles. If a named vector is provided, the names are used in the layer control legend.
#' @param basemaps.alpha transparency (opacity) value for the basemaps. Can be a vector of values, one for each basemap.
#' @param symbol.size.fixed should symbol sizes be fixed while zooming?
#' @param dot.size.fixed should dot sizes be fixed while zooming?
#' @param set.bounds logical that determines whether maximum bounds are set, or a numeric vector of four values that specify the lng1, lat1, lng2, and lat2 coordinates (see \code{\link[leaflet:setMaxBounds]{setMaxBounds}}).
#' @param set.view numeric vector or three that determines the view: lng, lat, and zoom (see \code{\link[leaflet:setView]{setView}}).
#' @param set.zoom.limits numeric vector of two that set the minimum and maximum zoom levels (see \code{\link[leaflet:tileOptions]{tileOptions}}).
#' @param legend.position Character vector of two values, specifing the position of the legend. Use "left" or "right" for the first value and "top" or "bottom" for the second value. It overrides the value of \code{legend.position} of \code{\link{tm_layout}}, unless set to \code{NA}.
#' @param max maximum amount of units that are printed in view mode
#' @param control.position Character vector of two values, specifing the position of the layer control UI. Use "left" or "right" for the first value and "top" or "bottom" for the second value.
#' @param popup.all.data not used anymore. As of version 1.6, the popups are specified by the argument \code{popup.vars} in the layer functions \code{\link{tm_fill}}, \code{\link{tm_symbols}}, and \code{\link{tm_lines}}.
#' @param bg.overlay not used anymore as of version 1.7. Instead of an overlay, a background color is set, which is determined by \code{bg.color} of \code{\link{tm_layout}}, which is style dependent.
#' @param bg.overlay.alpha not used anymore as of version 1.7. Instead of an overlay, a background color is set. The trade-off between background and basemaps can now be set by \code{basemaps.alpha}
#' @example ../examples/tm_view.R
#' @seealso \code{\link{tmap_mode}} and \href{../doc/tmap-modes.html}{\code{vignette("tmap-modes")}}
#' @export
tm_view <- function(alpha=NA,
					colorNA=NULL,
					basemaps=NA,
					basemaps.alpha=NA,
					symbol.size.fixed=FALSE,
					dot.size.fixed=TRUE,
					set.bounds=FALSE,
					set.view=NA,
					set.zoom.limits=NA,
					legend.position=c("right", "top"),
					control.position=c("left", "top"),
					max = c(polygons=30000, points=20000, lines=20000),
					popup.all.data=NULL,
					bg.overlay=NULL,
					bg.overlay.alpha=NULL) {
	g <- list(tm_view=c(as.list(environment()), list(call=names(match.call(expand.dots = TRUE)[-1]))))
	class(g) <- "tm"
	g
}
