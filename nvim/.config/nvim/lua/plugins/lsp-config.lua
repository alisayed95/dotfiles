return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			-- servers are enabled by vim.lsp.enable() below; enabling them here too attaches duplicates
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- server defaults (cmd, filetypes, root) come from nvim-lspconfig's lsp/*.lua
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = { command = "clippy" },
					},
				},
			})
			vim.lsp.enable({
				"lua_ls",
				"html",
				"tsc",
				"pyright",
				"gopls",
				"kotlin_language_server",
				"rust_analyzer",
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local fzf = require("fzf-lua")
					map("gd",fzf.lsp_definitions, "[G]oto [D]efinition")
					map("gr", fzf.lsp_references, "[G]oto [R]eferences")
					map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})
		end,
	},
}
