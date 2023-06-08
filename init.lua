function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local config = {
  colorscheme = "onedark",
  polish = function()
    -- Misspelings
    vim.cmd [[
      cnoreabbrev W! w!
      cnoreabbrev W1 w!
      cnoreabbrev w1 w!
      cnoreabbrev Q! q!
      cnoreabbrev Q1 q!
      cnoreabbrev q1 q!
      cnoreabbrev Qa! qa!
      cnoreabbrev Qall! qall!
      cnoreabbrev Wa wa
      cnoreabbrev Wq wq
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq
      cnoreabbrev wq1 wq!
      cnoreabbrev Wq1 wq!
      cnoreabbrev wQ1 wq!
      cnoreabbrev WQ1 wq!
      cnoreabbrev W w
      cnoreabbrev Q q
      cnoreabbrev Qa qa
      cnoreabbrev Qall qall
    ]]

    -- Panes
    Map("n", "<C-W>|", "<C-W>v")
    Map("n", "<C-W>-", "<C-W>S")

    -- Indent
    Map("n", "<Tab>", ">>")
    Map("n", "<S-Tab>", "<<")
    Map("v", "<Tab>", ">gv")
    Map("v", "<S-Tab>", "<gv")

    -- Telescope
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<C-p>", builtin.find_files, {})
    vim.keymap.set("n", "\\", builtin.live_grep, {})
    vim.keymap.set("n", "<C-b>", builtin.buffers, {})
  end,
  options = {
    g = {
      mapleader = ",",
    },
    opt = {
      foldenable = false,
      foldlevel = 99999,
      foldlevelstart = 99999,
      colorcolumn = "80,100",
    },
    wo = {
      relativenumber = false,
    },
  },
  plugins = {
    { "kevinhwang91/nvim-ufo",                              enabled = false },
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.color.twilight-nvim" },
    { import = "astrocommunity.completion.copilot-lua-cmp" },
  },
      ["null-ls"] = function()
    local status_ok, null_ls = pcall(require, "null-ls")
    if status_ok then
      null_ls.setup {
        debug = false,
        sources = {
          null_ls.builtins.formatting.prettier,
        },
        on_attach = function(client)
          if client.resolved_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
          end
        end,
      }
    end
  end,
}

return config
