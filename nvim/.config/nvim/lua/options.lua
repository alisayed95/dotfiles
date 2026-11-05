vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.scrolloff = 8
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.updatetime = 100
vim.g.mapleader = " "
vim.g.skip_ts_context_commentstring_module = true
-- vim.keymap.set("n", "<leader>pv", "<cmd>Yazi<cr>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:."))
end, {desc= 'Copy file path'})

vim.keymap.set("v", "<leader>av", function()
  local from, to = vim.fn.getpos("v"), vim.fn.getpos(".")
  local lines = vim.fn.getregion(from, to, { type = vim.fn.mode() })
  local first, last = math.min(from[2], to[2]), math.max(from[2], to[2])
  local location = vim.fn.expand("%:p:.") .. ":" .. first .. (last > first and "-" .. last or "")
  vim.fn.setreg("+", table.concat({ location, "```" .. vim.bo.filetype, table.concat(lines, "\n"), "```" }, "\n"))
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
end, {desc= 'Copy selection for opencode'})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
