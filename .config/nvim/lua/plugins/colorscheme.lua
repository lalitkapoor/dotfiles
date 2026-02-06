return {
  {
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
