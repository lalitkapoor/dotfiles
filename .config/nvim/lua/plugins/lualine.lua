return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }

      -- Remove the clock from the right side
      opts.sections.lualine_z = {}
    end,
  },
}
