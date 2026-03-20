local lsp = require("lsp-zero")

lsp.preset("recommended")


vim.lsp.config("ts_ls", {
    flags = { debounce_text_changes = 300 }
})
vim.lsp.enable({ "ts_ls" })


lsp.ensure_installed({
    'ts_ls',
    'rust_analyzer',
    'jdtls',
'intelephense', 'php_cs_fixer', 'laravel_pint', 'phpactor'
    -- 'gopls'
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- auto format on save
    lsp.buffer_autoformat()
end)


-- Capabilities (for nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- LSP servers
local lspconfig = require("lspconfig")

lspconfig.intelephense.setup({
    capabilities = capabilities,
    filetypes = { "php" },
    root_dir = lspconfig.util.root_pattern(
        "composer.json",
        ".git"
    ),
     on_attach = function(client, bufnr)
        -- force-enable code actions (safety)
        client.server_capabilities.codeActionProvider = true
    end,
})



-- PHP / Filament
lspconfig.intelephense.setup({
    capabilities = capabilities,
    root_dir = util.root_pattern("composer.json", "artisan", ".git"),
    settings = {
        intelephense = {
            environment = {
                includePaths = {
                    "vendor/filament",
                },
            },
            files = {
                maxSize = 5000000,
            },
        },
    },
})


-- lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
   signs = true,
    underline = true,
    update_in_insert = false,
})
