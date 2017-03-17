(require 'wordjump)
(require 'utils)

(global-set-key (kbd "M-g e") 'elinx/list-words-of-current-line)
(global-set-key (kbd "C-a") 'elinx/jump-to-beg-of-line-or-first-character)
(global-set-key (kbd "C-w") 'elinx/kill-region-or-current-line)
(global-set-key (kbd "M-DEL") 'elinx/delete-till-the-beginning-of-line)
(global-set-key (kbd "M-w") 'elinx/copy-region-or-current-line)

(provide 'main)
