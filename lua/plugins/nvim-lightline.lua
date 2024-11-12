return {
  {
    "itchyny/lightline.vim",
    config = function()
      -- Optional: Lightline configuration goes here
      vim.g.lightline = {
        colorscheme = "wombat", -- Set your preferred colorscheme
        active = { left = { { "mode", "paste" }, { "gitbranch", "readonly", "filename", "modified" } } },
        component_function = { gitbranch = "fugitive#head" },
      }
    end
  },
}
