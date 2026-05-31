-- nvim-treesitter-textobjects `main` branch.
-- Keymaps are now set via vim.keymap.set, not the setup table.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    }

    local select = require 'nvim-treesitter-textobjects.select'
    local swap = require 'nvim-treesitter-textobjects.swap'
    local move = require 'nvim-treesitter-textobjects.move'
    local repeatable_move = require 'nvim-treesitter-textobjects.repeatable_move'

    local function sel(capture)
      return function()
        select.select_textobject(capture, 'textobjects')
      end
    end

    local selections = {
      ['a='] = '@assignment.outer',
      ['i='] = '@assignment.inner',
      ['l='] = '@assignment.lhs',
      ['r='] = '@assignment.rhs',
      ['a:'] = '@property.outer',
      ['i:'] = '@property.inner',
      ['l:'] = '@property.lhs',
      ['r:'] = '@property.rhs',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['ai'] = '@conditional.outer',
      ['ii'] = '@conditional.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
      ['af'] = '@call.outer',
      ['if'] = '@call.inner',
      ['am'] = '@function.outer',
      ['im'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
    }
    for lhs, capture in pairs(selections) do
      vim.keymap.set({ 'x', 'o' }, lhs, sel(capture), { desc = 'Select ' .. capture })
    end

    local swap_next = {
      ['<leader>na'] = '@parameter.inner',
      ['<leader>n:'] = '@property.outer',
      ['<leader>nm'] = '@function.outer',
    }
    for lhs, capture in pairs(swap_next) do
      vim.keymap.set('n', lhs, function()
        swap.swap_next(capture)
      end, { desc = 'Swap next ' .. capture })
    end

    local swap_prev = {
      ['<leader>pa'] = '@parameter.inner',
      ['<leader>p:'] = '@property.outer',
      ['<leader>pm'] = '@function.outer',
    }
    for lhs, capture in pairs(swap_prev) do
      vim.keymap.set('n', lhs, function()
        swap.swap_previous(capture)
      end, { desc = 'Swap prev ' .. capture })
    end

    local function goto_next_start(capture, group)
      return function()
        move.goto_next_start(capture, group or 'textobjects')
      end
    end
    local function goto_next_end(capture)
      return function()
        move.goto_next_end(capture, 'textobjects')
      end
    end
    local function goto_prev_start(capture)
      return function()
        move.goto_previous_start(capture, 'textobjects')
      end
    end
    local function goto_prev_end(capture)
      return function()
        move.goto_previous_end(capture, 'textobjects')
      end
    end

    local next_starts = {
      [']f'] = { '@call.outer', 'textobjects' },
      [']m'] = { '@function.outer', 'textobjects' },
      [']c'] = { '@class.outer', 'textobjects' },
      [']i'] = { '@conditional.outer', 'textobjects' },
      [']l'] = { '@loop.outer', 'textobjects' },
      [']s'] = { '@scope', 'locals' },
      [']z'] = { '@fold', 'folds' },
    }
    for lhs, spec in pairs(next_starts) do
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, goto_next_start(spec[1], spec[2]), { desc = 'Next ' .. spec[1] })
    end

    local next_ends = {
      [']F'] = '@call.outer',
      [']M'] = '@function.outer',
      [']C'] = '@class.outer',
      [']I'] = '@conditional.outer',
      [']L'] = '@loop.outer',
    }
    for lhs, capture in pairs(next_ends) do
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, goto_next_end(capture), { desc = 'Next end ' .. capture })
    end

    local prev_starts = {
      ['[f'] = '@call.outer',
      ['[m'] = '@function.outer',
      ['[c'] = '@class.outer',
      ['[i'] = '@conditional.outer',
      ['[l'] = '@loop.outer',
    }
    for lhs, capture in pairs(prev_starts) do
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, goto_prev_start(capture), { desc = 'Prev ' .. capture })
    end

    local prev_ends = {
      ['[F'] = '@call.outer',
      ['[M'] = '@function.outer',
      ['[C'] = '@class.outer',
      ['[I'] = '@conditional.outer',
      ['[L'] = '@loop.outer',
    }
    for lhs, capture in pairs(prev_ends) do
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, goto_prev_end(capture), { desc = 'Prev end ' .. capture })
    end

    vim.keymap.set({ 'n', 'x', 'o' }, ';', repeatable_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', repeatable_move.repeat_last_move_opposite)
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', repeatable_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', repeatable_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', repeatable_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', repeatable_move.builtin_T_expr, { expr = true })
  end,
}
