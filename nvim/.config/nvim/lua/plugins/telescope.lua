return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'xiyaowong/telescope-emoji.nvim' },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require 'telescope.actions'
    local open_with_trouble = require('trouble.sources.telescope').open
    require('telescope').setup {
      pickers = {
        find_files = {
          theme = 'ivy',
        },
        git_files = {
          theme = 'ivy',
        },
        live_grep = {
          theme = 'ivy',
        },
      },
      defaults = {
        file_ignore_patterns = {
          '^node_modules/',
          '^.turbo/',
          '^.next/',
          '^./.git/',
          '^./.devenv/',
        },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<esc>'] = actions.close,
            ['<c-t>'] = open_with_trouble,
          },
          n = { ['<c-t>'] = open_with_trouble },
        },
      },
      extensions = {
        ['ui-select'] = {
          -- require('telescope.themes').get_dropdown(),
          -- require('telescope.themes').get_ivy(),
          require('telescope.themes').get_cursor(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'git_worktree')
    pcall(require('telescope').load_extension 'emoji')
    pcall(require('telescope').load_extension 'noice')
    -- pcall(require('telescope').load_extension 'rest')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sp', function()
      require('telescope.builtin').find_files { hidden = true, no_ignore = true }
    end, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', '<cmd>Telescope git_files show_untracked=true<cr>', { desc = '[S]earch [F]iles' })
    -- vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files show_untracked=true<cr>', { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<C-p>', function()
      require('telescope').extensions.smart_open.smart_open {
        cwd_only = true,
        -- filename_first = false,
      }
    end, { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader><leader>', function()
    --   require('telescope').extensions.smart_open.smart_open {
    --     cwd_only = true,
    --     -- filename_first = false,
    --   }
    -- end, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>rv', function()
      require('telescope').extensions.rest.select_env()
    end, { desc = 'Rest [E]nvironment' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
