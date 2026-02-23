return {
  'ThePrimeagen/99',
  config = function()
    local _99 = require '99'

    -- For logging that is to a file if you wish to trace through requests
    -- for reporting bugs, i would not rely on this, but instead the provided
    -- logging mechanisms within 99.  This is for more debugging purposes
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)
    _99.setup {
      -- Use Anthropic API directly instead of OpenCode Zen
      model = 'anthropic/claude-opus-4-6',

      logger = {
        level = _99.DEBUG,
        path = '/tmp/' .. basename .. '.99.debug',
        print_on_error = true,
      },

      --- A new feature that is centered around tags
      -- Disable completion for now since we use blink.cmp
      -- completion = {
      --   --- Defaults to .cursor/rules
      --   -- I am going to disable these until i understand the
      --   -- problem better.  Inside of cursor rules there is also
      --   -- application rules, which means i need to apply these
      --   -- differently
      --   -- cursor_rules = "<custom path to cursor rules>"

      --   --- A list of folders where you have your own SKILL.md
      --   --- Expected format:
      --   --- /path/to/dir/<skill_name>/SKILL.md
      --   ---
      --   --- Example:
      --   --- Input Path:
      --   --- "scratch/custom_rules/"
      --   ---
      --   --- Output Rules:
      --   --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
      --   --- ... the other rules in that dir ...
      --   ---
      --   custom_rules = {
      --     'scratch/custom_rules/',
      --   },

      --   --- What autocomplete do you use.  We currently only
      --   --- support cmp right now
      --   source = 'cmp',
      -- },

      --- WARNING: if you change cwd then this is likely broken
      --- ill likely fix this in a later change
      ---
      --- md_files is a list of files to look for and auto add based on the location
      --- of the originating request.  That means if you are at /foo/bar/baz.lua
      --- the system will automagically look for:
      --- /foo/bar/AGENT.md
      --- /foo/AGENT.md
      --- assuming that /foo is project root (based on cwd)
      md_files = {
        'AGENTS.md',
      },
    }

    -- Create your own short cuts for the different types of actions
    -- Fill in function (with prompt)
    vim.keymap.set('n', '<leader>ai', function()
      _99.fill_in_function_prompt()
    end)

    -- Visual selection (with prompt)
    vim.keymap.set('v', '<leader>av', function()
      _99.visual_prompt()
    end)

    -- Stop all requests
    vim.keymap.set('n', '<leader>as', function()
      _99.stop_all_requests()
    end)
  end,
}
