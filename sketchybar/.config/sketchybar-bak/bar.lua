local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 40,
	color = colors.bar.bg,
	padding_righ = 2,
	padding_left = 2,
	y_offset = 8,
	-- blur_radius = 10,
	margin = 10,
	corner_radius = 10,
})
