preprocess_gt <- function(x, interactive) {
	bg.color <- NULL
	
	style <- options("tmap.style")
	tln <- paste("tm_style", style,sep="_" )
	if (!exists(tln)) {
		warning("Style ", style, " unknown; ", tln, " does not exist. Please specify another style with the option \"tmap.stype\".", call. = FALSE)
		tln <- "tm_style_default"
	}
	gt <- do.call(tln, args = list())$tm_layout
	
	gts <- x[names(x)=="tm_layout"]
	if (length(gts)) {
		gtsn <- length(gts)
		extraCall <- character(0)
		for (i in 1:gtsn) {
			gt[gts[[i]]$call] <- gts[[i]][gts[[i]]$call]
			if ("attr.color" %in% gts[[i]]$call) gt[c("earth.boundary.color", "legend.text.color", "title.color")] <- gts[[i]]["attr.color"]
			extraCall <- c(extraCall, gts[[i]]$call)
		}
		gt$call <- c(gt$call, extraCall)
	}
	
	if (any("tm_view" %in% names(x))) {
		gv <- x[[which("tm_view" == names(x))[1]]]
	} else {
		gv <- tm_view()$tm_view
	}
	
	## preprocess gt
	gt <- within(gt, {
		pc <- list(sepia.intensity=sepia.intensity, saturation=saturation)
		sepia.intensity <- NULL
		saturation <- NULL
		
		if (!"scientific" %in% names(legend.format)) legend.format$scientific <- FALSE
		if (!"digits" %in% names(legend.format)) legend.format$digits <- NA
		if (!"text.separator" %in% names(legend.format)) legend.format$text.separator <- "to"
		if (!"text.less.than" %in% names(legend.format)) legend.format$text.less.than <- "Less than"
		if (!"text.or.more" %in% names(legend.format)) legend.format$text.or.more <- "or more"
		
		# put aes colors in right order and name them
		if (length(aes.color)==1 && is.null(names(aes.color))) names(aes.color) <- "base"
		
		if (!is.null(names(aes.color))) {
			aes.colors <- c(fill="grey85", borders="grey40", bubbles="blueviolet", dots="black", lines="red", text="black", na="grey60")
			aes.colors[names(aes.color)] <- aes.color
		} else {
			aes.colors <- rep(aes.color, length.out=7)
			names(aes.colors) <- c("fill", "borders", "bubbles", "dots", "lines", "text", "na")
		}
		aes.colors <- sapply(aes.colors, function(ac) if (is.na(ac)) "#000000" else ac)
		
		# override na
		if (interactive) aes.colors["na"] <- if (is.null(gv$na)) "#00000000" else if (is.na(gv$na)) aes.colors["na"] else gv$na
		
		if (is.null(bg.overlay)) bg.overlay <- bg.color
		
		aes.colors.light <- sapply(aes.colors, is_light)
		aes.color <- NULL
		
	})
	
	# process view
	gv <- within(gv, {
		if (!working_internet() || identical(as.numeric(bg.overlay.alpha), 1) || identical(basemaps, FALSE)) {
			# solid background
			if (is.na(bg.overlay.alpha)) bg.overlay.alpha <- 1
			basemaps <- character(0)
			if (is.na(alpha)) alpha <- 1
		} else {
			# with basemap tiles
			if (is.na(bg.overlay.alpha)) bg.overlay.alpha <- gt$bg.overlay.alpha
			if (identical(basemaps, TRUE)) basemaps <- gt$basemaps
			if (is.na(alpha)) alpha <- .7
		}
		if (is.na(bg.overlay)) bg.overlay <- gt$bg.overlay
		bg.overlay <- split_alpha_channel(bg.overlay, alpha=1)$col
		na <- NULL
		call <- NULL
	})
	
	# append view to layout
	gt[c("basemaps", "bg.overlay", "bg.overlay.alpha")] <- NULL
	gt <- c(gt, gv)
	
	gtnull <- names(which(sapply(gt, is.null)))
	gt[gtnull] <- list(NULL)
	gt
}