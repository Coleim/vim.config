require("config.remap")
require("config.nvim-tree")
require("config.lazy")

vim.wo.number = true
vim.wo.relativenumber = true


-- Set tab and indent options
vim.opt.tabstop = 2        -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2     -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Enable smart indentation
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#353d46" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#353d46" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3e4452" })




--vim.api.nvim_create_autocmd("InsertLeave", {
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.bo.filetype ~= "php" then
      vim.lsp.buf.format()
    end
  end,
})
