return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  opts = {
    provider = 'openrouter',
    vendors = {
      ['openrouter'] = {
        endpoint = 'https://openrouter.ai/api/v1/chat/completions', -- The full endpoint of the provider
        model = 'openai/gpt-4o', -- The model name to use with this provider
        api_key_name = 'OPENAI_API_KEY', -- The name of the environment variable that contains the API key
        -- --- This function below will be used to parse in cURL arguments.
        -- --- It takes in the provider options as the first argument, followed by code_opts retrieved from given buffer.
        -- --- This code_opts include:
        -- --- - question: Input from the users
        -- --- - code_lang: the language of given code buffer
        -- --- - code_content: content of code buffer
        -- --- - selected_code_content: (optional) If given code content is selected in visual mode as context.
        ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ['Accept'] = 'application/json',
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ' .. vim.env[opts.api_key_name],
            },
            body = {
              model = opts.model,
              messages = require('avante.providers').openai.parse_message(code_opts), -- you can make your own message, but this is very advanced
              max_tokens = 2048,
              stream = true,
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require('avante.providers').openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
  },
  keys = {
    {
      '<leader>aa',
      function()
        require('avante.api').ask()
      end,
      desc = 'avante: ask',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ar',
      function()
        require('avante.api').refresh()
      end,
      desc = 'avante: refresh',
    },
    {
      '<leader>ae',
      function()
        require('avante.api').edit()
      end,
      desc = 'avante: edit',
      mode = 'v',
    },
  },
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to setup it properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
