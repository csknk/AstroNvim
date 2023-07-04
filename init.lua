vim.g.markdown_fenced_languages = {
  "bash",
  "python",
  "sh",
  "go",
  "rust",
  "c",
  "cpp",
  "lua",
  "json",
}

return {
  plugins = {
    -- init = {
    --   ["L3MON4D3/LuaSnip"] = { module = "" },
    -- },
    -- {
    --   "L3MON4D3/LuaSnip",
    --   config = function(plugin, opts)
    --     require "plugins.configs.luasnip" (plugin, opts)                                                              -- include the default astronvim config that calls the setup call
    --     require("luasnip.loaders.from_vscode").lazy_load { paths = { "/home/david/.config/nvim/lua/user/snippets" } } -- load snippets paths
    --     -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } } -- load snippets paths
    --     -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } } -- load snippets paths
    --   end,
    -- },
  },
  -- More Go stuff: https://go.googlesource.com/tools/+/refs/heads/master/gopls/doc/vim.md#neovim-config
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrodark",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Start certain filetypes with a template
    local function bash_skeleton()
      vim.cmd(string.format("0put =readfile('%s')", "/home/david/.config/nvim/skeleton/bash.sh")) -- Insert template contents
      vim.api.nvim_command("normal! G")                                                           -- Jump to the end of the document
      vim.api.nvim_feedkeys("o", "n", true)                                                       -- Add line & switch to insert mode
    end
    vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*.sh", callback = function() bash_skeleton() end })

    -- Add gates to c/c++ header files
    local function insert_gates()
      local gatename = vim.fn.expand("%:t"):upper():gsub("%.", "_")
      vim.api.nvim_command("normal! i#ifndef " .. gatename)
      vim.api.nvim_command("normal! o#define " .. gatename)
      vim.api.nvim_command("normal! o")
      vim.api.nvim_command("normal! Go#endif /* " .. gatename .. " */")
      vim.api.nvim_command("normal! ^k")
    end
    vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*.{h,hpp}", callback = function() insert_gates() end })

    -- Spellcheck for specified filetypes
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" },
      { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" })

    -- Organise imports on save using the logic of `goimports`
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
      end
    })
    -- vim.api.nvim_set_keymap("n", "<leader>fp", ":!realpath %<CR>", { noremap = true })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    -- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./lua/user/snippets" } })
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/user/luasnippets" } })
  end,
}
