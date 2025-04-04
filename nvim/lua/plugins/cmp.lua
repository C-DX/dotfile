return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "normal",
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        completion = { menu = { auto_show = true } },
      },
    },
  },
}
