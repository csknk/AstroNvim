return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim.prettier/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      null_ls.builtins.code_actions.gomodifytags
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.completion.luasnip, -- commented out 01/05/2023
      -- null_ls.builtins.formatting.prettier,
      -- null_ls.builtins.completion.spell,
      -- null_ls.builtins.diagnostics.checkmake,
      -- null_ls.builtins.formatting.clang_format,
      -- null_ls.builtins.formatting.fixjson,
      -- null_ls.builtins.hover.dictionary,
    }
    return config -- return final config table
  end,
}
