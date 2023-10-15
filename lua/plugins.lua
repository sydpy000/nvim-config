-----------------
-- Packer.nvim --
-----------------
-- Install Packer automatically if it"s not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()
-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require("packer").startup(function(use)
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- LSP manager
        use { "williamboman/mason.nvim" }
        use { "williamboman/mason-lspconfig.nvim" }
        use { "neovim/nvim-lspconfig" }

        -- Auto-completion engine
        -- Note:
        --     the default search path for `require` is ~/.config/nvim/lua
        --     use a `.` as a path seperator
        --     the suffix `.lua` is not needed
        use { "hrsh7th/nvim-cmp", config = [[require("config.nvim-cmp")]] }
        use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
        use { "hrsh7th/cmp-buffer", after = "nvim-cmp" } -- buffer auto-completion
        use { "hrsh7th/cmp-path", after = "nvim-cmp" } -- path auto-completion
        use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" } -- cmdline auto-completion

        -- Code snippet engine
        use { "L3MON4D3/LuaSnip" }
        use { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } }

        -- Colorscheme
        use { "tanvirtin/monokai.nvim" }

        -- Treesitter-integration
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
                ts_update()
            end,
            config = [[require("config.nvim-treesitter")]],
        }

        -- Debugging
        use { "mfussenegger/nvim-dap" }
        use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require("config.lualine")]],
        }

        -- File explorer
        use {
            "nvim-tree/nvim-tree.lua",
            requires = {
                "nvim-tree/nvim-web-devicons", -- optional, for file icons
            },
            config = [[require("config.nvim-tree")]]
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = { {"nvim-lua/plenary.nvim"} },
            config = [[require("config.telescope")]],
        }
        use { "nvim-telescope/telescope-dap.nvim" }
        use { "nvim-telescope/telescope-ui-select.nvim" }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require("packer").sync()
        end
    end)
