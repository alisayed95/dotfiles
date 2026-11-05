return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,
				-- Typescript
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d"),
				-- Python
				null_ls.builtins.formatting.black,
				require("none-ls.diagnostics.flake8"),
				-- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.diagnostics.golangci_lint,
        -- Kotlin
        null_ls.builtins.formatting.ktlint,
        null_ls.builtins.diagnostics.ktlint,
			},
		})
		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
