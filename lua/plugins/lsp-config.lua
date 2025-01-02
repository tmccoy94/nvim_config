return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
					"ts_ls",
					"powershell_es",
					"sqlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.kind = {
				-- Explicitly allow only the completion item kinds you want
				"Method",
				"Function",
				"Constructor",
				"Field",
				"Variable",
				"Class",
				"Interface",
				"Module",
				"Property",
				"Unit",
				"Value",
				"Enum",
				"Keyword",
				"Snippet",
				"Color",
				"File",
				"Reference",
				"Folder",
				"EnumMember",
				"Constant",
				"Struct",
				"Event",
				"Operator",
				"TypeParameter",
			}

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT for Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- Change to "strict" for stricter checks
							autoImportCompletions = true,
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})
			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})
			lspconfig.powershell_es.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd", "--header-insertion=never", "--compile-commands-dir=." },
				init_options = {
					fallbackFlags = {
						"-I/mingw64/include", -- Include directory for headers
						"-L/mingw64/lib", -- Library directory
						"-lcs50", -- Link against cs50
					},
					root_dir = function(fname)
						-- Force clangd to treat the directory containing recursion.c as the root
						return vim.loop.cwd()
					end,
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
