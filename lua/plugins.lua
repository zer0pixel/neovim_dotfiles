local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup({
	function(use)
		use({
			"wbthomason/packer.nvim", -- Have packer manage itself
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use("simnalamburt/vim-mundo") -- visualize neovim's undo graph

		use({
			"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use("windwp/nvim-ts-autotag")

		use({
			"numToStr/Comment.nvim", -- Easily comment stuff
			requires = {
				"JoosepAlviste/nvim-ts-context-commentstring",
			},
		})

		use("preservim/tagbar") -- Displays a class outline (needs exuberant ctags)

		use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

		use({
			"nvim-tree/nvim-tree.lua",
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
		})

		use("godlygeek/tabular") -- vertically align text (see: :Tabularize)

		use("moll/vim-bbye") -- Preserves layout when closing buffers  (see: :Bdelete, :Bwipeout)

		use({
			"nvim-lualine/lualine.nvim", -- eyecandy
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"akinsho/toggleterm.nvim", -- terminal inside neovim
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"lewis6991/impatient.nvim", -- Improves loading times for lua files
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

		-- Colorschemes
		use("tanvirtin/monokai.nvim")

		-- completion plugins
		use("onsails/lspkind-nvim") -- vscode-like pictograms
		use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
		use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
		use("hrsh7th/nvim-cmp") -- The completion plugin
		use("L3MON4D3/LuaSnip")

		use({
			"williamboman/mason.nvim",  -- simple to use language server installer
			"williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
			"neovim/nvim-lspconfig",    -- Configures Language Server Protocol (LSP) servers
		})
		use("simrat39/rust-tools.nvim") -- extra functionality over rust analyzer

		use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for

		use({
			"jose-elias-alvarez/null-ls.nvim", -- language server that runs formatters and linters found in $PATH
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"nvim-telescope/telescope.nvim", -- fuzzy finder
			requires = {
				"nvim-lua/plenary.nvim",
				"ANGkeith/telescope-terraform-doc.nvim",
			},
		})

		use({
			"NTBBloodbath/rest.nvim", -- HTTP client for nvim (Requires curl, jq)
			-- Also requires the following TreeSitter parsers: {http, json}
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"folke/which-key.nvim", -- Display keymappings for plugins that support it
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter", -- generates syntax tree from sources used for better highlighting
			run = ":TSUpdate",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"tpope/vim-fugitive", -- Git on steroids :P
			requires = {
				"tpope/vim-rhubarb",
			},
		})

		use("lewis6991/gitsigns.nvim") -- marks new/modified/deleted lines in buffer

		use("mattn/emmet-vim")   -- compose html using css selector syntax

		use("rodjek/vim-puppet") -- helpers for puppet

		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end,
	config = {
		compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), ".plugin", "packer_compiled.lua"),
	},
})
