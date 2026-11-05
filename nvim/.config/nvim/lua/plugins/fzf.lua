return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})

			local fzf = require("fzf-lua")

			vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[s]earch [f]iles" })
			vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[s]earch current [w]ord" })
			vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[s]earch by [g]rep" })
			vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[s]earch [r]esume" })
			vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] find existing buffers" })
      vim.keymap.set("n", "<leader>gs", fzf.git_status, { desc = "[g]it [s]tatus" })

		end,
	},
}
