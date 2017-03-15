;; list words of current line using helm framework
(defvar elinx/words-alist '())

(defun elinx/words-of-current-line ()
  (save-excursion
    (with-helm-current-buffer
      (goto-char (line-beginning-position))
      (cl-loop while (re-search-forward "\\b\\w+\\b" (line-end-position) t)
        collect (list (match-string 0) (point))))))

(defun elinx/jump-to-word (candidate)
  (with-helm-current-buffer
    (goto-char (car candidate))))

(defun elinx/list-words-of-current-line ()
  (interactive)
  (helm :sources (helm-build-sync-source "Words of Current Line"
                   :candidates 'elinx/words-of-current-line
                   :action 'elinx/jump-to-word)
        :buffer "*Words of Current Line*"))

(global-set-key (kbd "M-g e") 'elinx/list-words-of-current-line)
