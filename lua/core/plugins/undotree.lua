return {
  'mbbill/undotree',
  cmd = { 'UndotreeToggle' },
  keys = {
    { '<leader>u', vim.cmd.UndotreeToggle, desc = '[U]ndo Tree' },
  }
}
