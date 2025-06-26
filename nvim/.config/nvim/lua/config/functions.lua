vim.filetype.add {
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/templates/.*%.tmpl'] = 'helm',
    ['.*/templates/.*%.ya?ml'] = 'helm',
  },
}

vim.cmd [[
  command! -nargs=1 SearchFolder lua require('config.functions').search_folder(<f-args>)
  command! DeleteAllButCurrentBuffer lua require('config.functions').delete_all_but_current_buffer()
  command! CloseBuffer lua require('config.functions').close_buffer()
  command! ForceCloseBuffer lua require('config.functions').force_close_buffer()
  command! ChangeWorktree lua require('config.functions').change_worktree()
  command! CopyBuffer let @+ = fnamemodify(expand('%'), ':~:.')
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

function count_bufs_by_type(loaded_only)
  loaded_only = (loaded_only == nil and true or loaded_only)
  count = { normal = 0, acwrite = 0, help = 0, nofile = 0, nowrite = 0, quickfix = 0, terminal = 0, prompt = 0 }
  buftypes = vim.api.nvim_list_bufs()
  for t, bufname in pairs(buftypes) do
    if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
      buftype = vim.api.nvim_buf_get_option(bufname, 'buftype')
      buftype = buftype ~= '' and buftype or 'normal'
      count[buftype] = count[buftype] + 1
    end
  end
  return count
end

function M.close_buffer()
  local bufTable = count_bufs_by_type()
  if bufTable.normal <= 1 then
    vim.cmd 'bd'
    vim.cmd 'Dashboard'
  else
    vim.cmd 'bd'
  end
end

function M.force_close_buffer()
  local bufTable = count_bufs_by_type()
  if bufTable.normal <= 1 then
    vim.cmd 'bd!'
    vim.cmd 'Dashboard'
  else
    vim.cmd 'bd!'
  end
end

function M.change_worktree()
  vim.cmd 'e .'
  M.close_buffer()
end

return M
