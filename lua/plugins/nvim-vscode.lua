return {
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        -- Theme-specific options (optional)
        style = "dark", -- or "light"
        transparent = true,
        italic_comments = true
      })
      -- Enable the colorscheme
      vim.cmd("colorscheme vscode")
    end,
  },
}
