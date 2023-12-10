local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand


-- --Format on save
-- augroup('FormatAutogroup',{})
-- autocmd('FormatWrite', {
--  group = 'FormatAutogroup',
--  callback = function ()
--     vim.lsp.buf.format({ async = true })
--  end
-- })


