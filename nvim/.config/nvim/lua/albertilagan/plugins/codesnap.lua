return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  opts = {
    save_path = '~/Pictures/screenshots',
    bg_x_padding = 30,
    bg_y_padding = 30,
    bg_padding = nil,
    watermark = '',
    has_breadcrumbs = true,
    has_line_number = true,
    bg_theme = 'grape',
  },
}
