local function bash_crunchbang()
    vim.api.nvim_feedkeys("n", "i#!/usr/bin/env bash\\<CR>", true)
    vim.api.nvim_feedkeys("n", "oset -euo pipefail\\<CR>", true)
    vim.api.nvim_feedkeys("oIFS=$'\\n\\t'\\<CR>", "n", true)
    vim.api.nvim_feedkeys("o", "n", true)
    vim.api.nvim_feedkeys("^3j", "n", true)
end

-- Call bash_crunchbang when opening a new shell script file
require('core.autocmd').add_listener('AstroNewFile', '*', function()
    if vim.fn.expand('%:e') == 'sh' then
        bash_crunchbang()
    end
end)
