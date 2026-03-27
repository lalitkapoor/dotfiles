return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      options = {
        show_all_diags_on_cursorline = true,
        multilines = {
          enabled = true,
        },
        use_icons_from_diagnostic = true,
        enable_on_insert = false,
        overflow = {
          mode = "wrap",
        },
      },
    },
  },
  -- Disable built-in virtual text so it doesn't duplicate with tiny-inline-diagnostic
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
