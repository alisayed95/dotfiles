return {
  "nvim-treesitter/nvim-treesitter",
  -- main is the rewrite for nvim 0.12+; it doesn't support lazy-loading
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- start treesitter for any filetype with an installed parser
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
