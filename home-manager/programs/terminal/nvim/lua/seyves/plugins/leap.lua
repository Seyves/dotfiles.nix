vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
require('leap').opts.highlight_unlabeled_phase_one_targets = true
require('leap').opts.case_sensitive = true
