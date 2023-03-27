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

Bash_crunchbang = function()
  if not vim.g.bash_crunchbang_autocmd_added then
    vim.g.bash_crunchbang_autocmd_added = true
    vim.cmd("normal! i#!/usr/bin/env bash")
    vim.cmd("normal! o")
    vim.cmd("normal! x")
    vim.cmd("normal! set -euo pipefail")
    vim.cmd("normal! oIFS=$'\\n\\t'")
    vim.cmd("normal! o")
    vim.cmd("normal! ^3j")
    vim.cmd("autocmd! BufNewFile *.{sh} lua bash_crunchbang()")
  end
end

return {
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
    local function skeleton()
      vim.cmd("0put =readfile('/home/david/.config/nvim/skeleton/bash.sh')") -- Insert contents of ~/.config/nvim/skeleton/bash.sh at line 0
      vim.api.nvim_command("normal! $")                                      -- Jump to the end of the document
      vim.api.nvim_feedkeys("i", "n", true)                                  -- Switch to insert mode
    end
    vim.api.nvim_create_autocmd("BufNewFile", {
      pattern = "*.sh",
      callback = function() skeleton() end,
    })
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
  end,
}
