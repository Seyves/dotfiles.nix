local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add file to harpoon list" })
vim.keymap.set("n", "<leader>ho", ui.toggle_quick_menu, { desc = "Open harpoon list" })

vim.keymap.set("n", "<leader>hh", function() ui.nav_file(1) end, { desc = "Harpoon first file" })
vim.keymap.set("n", "<leader>hj", function() ui.nav_file(2) end, { desc = "Harpoon second file" })
vim.keymap.set("n", "<leader>hk", function() ui.nav_file(3) end, { desc = "Harpoon third file" })
vim.keymap.set("n", "<leader>hl", function() ui.nav_file(4) end, { desc = "Harpoon fourth file" })
