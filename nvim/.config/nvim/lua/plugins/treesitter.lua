-- nvim-treesitter `main` branch (rewritten for Neovim 0.12+).
-- The old `require('nvim-treesitter.configs').setup{}` API is gone.
-- `incremental_selection` has no replacement on main — keymaps dropped.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    require('nvim-treesitter').install {
      'bash',
      'c',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'yaml',
      'make',
      'dockerfile',
      'typescript',
      'tsx',
      'javascript',
      'json',
      'css',
      'go',
      'sql',
      'gotmpl',
      'helm',
      'http',
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if vim.treesitter.language.add(lang) then
          vim.treesitter.start(args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Shim master-branch APIs that downstream plugins (telescope previewer,
    -- etc.) still call. Main branch removed these in favor of vim.treesitter.
    package.loaded['nvim-treesitter.parsers'] = {
      ft_to_lang = function(ft)
        return vim.treesitter.language.get_lang(ft) or ft
      end,
      get_parser_configs = function()
        return {}
      end,
      has_parser = function(lang)
        return pcall(vim.treesitter.language.add, lang)
      end,
      get_parser = function(bufnr, lang)
        pcall(vim.treesitter.language.add, lang)
        return vim.treesitter.get_parser(bufnr, lang)
      end,
    }
    package.loaded['nvim-treesitter.configs'] = {
      is_enabled = function(mod, _lang, _bufnr)
        return mod == 'highlight'
      end,
      get_module = function(mod)
        if mod == 'highlight' then
          return { additional_vim_regex_highlighting = false }
        end
        return nil
      end,
      setup = function() end,
    }
  end,
}
