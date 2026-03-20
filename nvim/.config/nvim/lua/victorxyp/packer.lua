-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }


    -- colorscheme rose-pine
    -- use({ 'rose-pine/neovim', as = 'rose-pine' })
    --vim.cmd('colorscheme rose-pine')
    -- colorscheme tokyonight
    use({ 'folke/tokyonight.nvim' })
    vim.cmd('colorscheme tokyonight')

    use {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }

    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('preservim/nerdtree')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')
    -- Surround
    use('tpope/vim-surround')

    use {
        "adibhanna/laravel.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            -- "nvim-neotest/nio.nvim",
        },
        config = function()
            require('laravel').setup({
                notifications = true,
                debug = true,
                keymaps = true,
                sail = {
                    enabled = true,
                    auto_detect = true,
                },
            })
        end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional


            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required

            -- DAP
            { "mfussenegger/nvim-dap" },
            { "rcarriga/nvim-dap-ui" },
            { "jay-babu/mason-nvim-dap.nvim" },
        }
    }
    use {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }
    use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }


    use { 'neoclide/coc.nvim', branch = 'release' }

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    use({'yaegassy/coc-laravel', run= 'yarn install --frozen-lockfile'})
    use {"sindrets/diffview.nvim" }
    -- Copilot
    -- use{ 'CopilotC-Nvim/CopilotChat.nvim', requires = { 'nvim-lua/plenary.nvim'}, run = "make tiktoken" }
end)
