return {
  'dmtrKovalenko/fff.nvim',
  build = 'cargo build --release',
  -- or if you are using nixos
  -- build = "nix run .#release",
  opts = {
    keymaps = {
      select = '<CR>',
      close = { '<Esc>', '<C-c>' },
      select_split = '<C-s>',
      select_vsplit = '<C-v>',
      select_tab = '<C-t>',
      move_up = { '<Up>', '<C-p>', '<C-k>' },
      move_down = { '<Down>', '<C-n>', '<C-j>' },
      preview_scroll_up = '<C-u>',
      preview_scroll_down = '<C-d>',
      toggle_debug = '<F2>',
    },
  },
  keys = {
    {
      '<C-p>', -- try it if you didn't it is a banger keybinding for a picker
      function()
        require('fff').find_files() -- or find_in_git_root() if you only want git files
      end,
      desc = 'Open file picker',
    },
    {
      'ff', -- try it if you didn't it is a banger keybinding for a picker
      function()
        require('fff').find_files() -- or find_in_git_root() if you only want git files
      end,
      desc = 'Open file picker',
    },
  },
}
