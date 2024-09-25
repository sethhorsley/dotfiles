return {
  "chentoast/marks.nvim",
  config = function()
    require("marks").setup({
      -- whether to map keybinds or not. default true
      default_mappings = true,
    })
  end,
}
