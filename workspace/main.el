;; list words of current line using helm framework
(defun elinx/words-of-current-line ()
  (save-excursion
    (with-helm-current-buffer
      (goto-char (line-beginning-position))
      (cl-loop while (re-search-forward "\\b\\w+\\b" (line-end-position) t)
        collect (match-string 0)))))

(defun elinx/list-words-of-current-line ()
  (interactive)
  (helm :sources (helm-build-sync-source "Words of Current Line"
                  :candidates 'elinx/words-of-current-line)
        :buffer "*Words of Current Line*"))

(global-set-key (kbd "C-x w") 'elinx/list-words-of-current-line)
