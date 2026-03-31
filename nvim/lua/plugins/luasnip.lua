return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  dependencies = {
    {
      "mlaursen/vim-react-snippets",
      opts = {
        readonly_props = true, -- Set to `false` if all props should no longer be wrapped in `Readonly<T>`.
        test_framework = "@jest/globals", -- Set to "vitest" if you use vitest
        test_renderer_path = "@testing-library/user-event", -- Set to a custom test renderer. For example "@/test-utils"
      },
    },
  },
}
