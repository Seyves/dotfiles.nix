local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add file to harpoon list" })
vim.keymap.set("n", "<leader>ho", ui.toggle_quick_menu, { desc = "Open harpoon list" })

vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "Harpoon first file" })
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = "Harpoon second file" })
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "Harpoon third file" })
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = "Harpoon fourth file" })
vim.keymap.set("n", "<leader>h5", function() ui.nav_file(5) end, { desc = "Harpoon fifth file" })
