vim.cmd [[
  command! -nargs=1 SearchFolder lua require('albertilagan.config.autocmds').search_folder(<f-args>)
  command! DeleteAllButCurrentBuffer lua require('albertilagan.config.autocmds').delete_all_but_current_buffer()
]]

local M = {}

function M.search_folder(folder)
  vim.cmd(string.format('Telescope live_grep search_dirs={"%s"}', folder))
end

function M.delete_all_but_current_buffer()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end

return M
