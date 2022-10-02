local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

packer.init({
	-- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
	compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "plugin", "packer_compiled.vim"),
	git = { clone_timeout = 300 },
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim" })

	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Buffer Bar
	-- use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }
	use({
		"akinsho/nvim-bufferline.lua",
		config = function()
			require("nv-bufferline").config()
		end,
		event = "BufRead",
	})

	-- whichkey
	use({ "folke/which-key.nvim" })

	use({ "tpope/vim-surround" })

	-- Colorscheme
	use("tiagovla/tokyodark.nvim")
	use("Mofiqul/vscode.nvim")

	-- Symbol Outline
	use({ "simrat39/symbols-outline.nvim" })
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Dash
	use({ "glepnir/dashboard-nvim" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		-- 	requires = {
		-- 		{ "nvim-lua/popup.nvim" },
		-- 		{ "nvim-lua/plenary.nvim" },
		-- 	},
	})

	use({ "lukas-reineke/indent-blankline.nvim" })

	-- Nvim Tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("nv-nvimtree").config()
		end,
	})

	-- Nvim Built in LSP configs
	use({ "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" })
	use("onsails/lspkind-nvim")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use({ "tami5/lspsaga.nvim", branch = "nvim6.0" or "nvim51" })

	--completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "quangnguyen30192/cmp-nvim-ultisnips" },
		},
		config = function()
			require("nv-cmp").config()
		end,
	})
	--debugger
	use("mfussenegger/nvim-dap")
	use("Pocco81/DAPInstall.nvim")

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		after = { "telescope.nvim", "nvim-cmp" },
		config = function()
			require("nv-autopairs")
		end,
	})

	-- Comments
	use({
		"terrortylor/nvim-comment",
		cmd = "CommentToggle",
		config = function()
			require("nvim_comment").setup({ comment_empty = false })
		end,
	})

	-- Zen Mode
	use({
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		-- event = "BufRead",
		config = function()
			require("nv-zen").config()
		end,
	})

	use({ "norcalli/nvim-colorizer.lua" })
	-- Color Pick
	use({ "KabbAmine/vCoolor.vim" }) -- alt-c to color pick

	use({ "lervag/vimtex" })
	use({ "vimwiki/vimwiki" })
	-- use("renerocksai/telekasten.nvim")
	-- use({
	-- 	"nvim-neorg/neorg",
	-- 	config = function()
	-- 		require("nv-neorg").config()
	-- 	end,
	-- 	requires = "nvim-neorg/neorg-telescope", -- Be sure to pull in the repo
	-- })
	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup()
		end,
	})

	use({ "sirver/ultisnips" })

	-- Ranger
	use({ "kevinhwang91/rnvimr" })

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Floating terminal
	use({ "akinsho/toggleterm.nvim" })

	use({
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
	-- use({ "JuliaEditorSupport/julia-vim" })
	use({ "jpalardy/vim-slime" })
	-- use({ "michaelb/sniprun", run = "bash ./install.sh" })
	use({
		"nyngwang/NeoRoot.lua",
		config = function()
			require("neo-root").setup({
				CUR_MODE = 2, -- 1 for file/buffer mode, 2 for proj-mode
			})
		end,
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
end)
