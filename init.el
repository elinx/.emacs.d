;;; packages repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'light)
;;(set-frame-parameter nil 'background-mode 'dark)
;; (add-hook 'after-make-frame-functions
;;           (lambda (frame)
;;             (let ((mode (if (display-graphic-p frame) 'dark 'light)))
;;               (set-frame-parameter frame 'background-mode mode)
;;               (set-terminal-parameter frame 'background-mode mode))
;;             (enable-theme 'solarized)))

;;; yes => y, no => n
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)

;;; global setups
(global-linum-mode)



(defconst cool-packages
  '(anzu
    company
    duplicate-thing
    helm
    helm-projectile
    helm-swoop
    iedit
    projectile
    duplicate-thing
    clean-aindent-mode
    comment-dwim-2
    yasnippet
    dtrt-indent
    ws-butler
    iedit
    yasnippet
    smartparens
    ))

(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package cool-packages)
    (unless (package-installed-p package)
      (package-install package))))

;; (install-packages)			


;;; helm configure
(require 'helm)
(require 'helm-config)
(require 'helm-projectile)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(helm-autoresize-mode t)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


;;; irony mode
(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)



;;; company mode
(require 'company)
(global-company-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
;; (global-set-key "\t" 'company-complete-common)
(setq company-idle-delay 0)



;;; flycheck mode
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
  '(add-to-list 'flycheck-mode-hook #'flycheck-irony-setup))



;;; eldoc mode
(add-hook 'irony-mode-hook 'irony-eldoc)



;;; spaceline config
(require 'spaceline-config)
(spaceline-spacemacs-theme)


;;; window-numbering-mode
(window-numbering-mode)



;;; anzu mode
(global-anzu-mode +1)
;;(anzu-mode +1)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)



;;; c style
(setq c-default-style "linux"
      c-basic-offset 8)
(setq comment-style 'extra-line)	; useful when comment out a block


;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative))
 '(tool-bar-mode nil))

;; key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))


;;; duplicate-thing
(require 'duplicate-thing)
(global-set-key (kbd "M-c") 'duplicate-thing)


;;; clean aindent mode
(require 'clean-aindent-mode)
(define-key global-map (kbd "RET") 'newline-and-indent)



;;; comment
(global-set-key (kbd "M-;") 'comment-dwim-2)



;;; swoop
(global-set-key (kbd "C-c h o") 'helm-swoop)
(setq helm-swoop-split-with-multiple-windows nil)
;; (setq helm-swoop-split-direction 'split-window-vertically)
(setq helm-swoop-split-direction 'split-window-horizontally)
(setq helm-swoop-move-to-line-cycle t)
(setq helm-swoop-use-line-number-face t)
(setq helm-swoop-use-fuzzy-match t)


;;; iedit
(setq iedit-toggle-key-default nil)
(require 'iedit)
(global-set-key (kbd "C-;") 'iedit-mode)


;;; yasnippet
(require 'yasnippet)
(yas-global-mode)


;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)



;; Package: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)


;; disable the toolbar
(tool-bar-mode -1)

;; redirect temp files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; and auto delete the back files
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight semi-bold :height 143 :width normal)))))


;;; shell
(setq shell-file-name "/bin/bash")

;;; toggle beginning of line or fist char of current line by stroke "C-a"
(defun elinx/jump-to-beg-of-line-or-first-character()
  "jump to the beginning of line or the fist character of current line"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))
(global-set-key (kbd "C-a") 'elinx/jump-to-beg-of-line-or-first-character)

;;; select beginning with stroking "M-SPC"
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;; kill region or current line by stroke "C-w"
(defun elinx/kill-region-or-current-line (beg end)
  "kill selected region or current line"
  (interactive "r")
  (if (region-active-p)
      (kill-region beg end)
    (kill-whole-line)))
(global-set-key (kbd "C-w") 'elinx/kill-region-or-current-line)

(defun elinx/delete-till-the-beginning-of-line()
  "delete backward till the beginning of current line"
  (interactive)
  (let ((cur-pos (point)))
    (beginning-of-line)
    (let ((beg-of-line-pos (point)))
      (goto-char cur-pos)
      (backward-word)
      (let ((backward-word-pos (point)))
	(goto-char cur-pos)
	(if (> beg-of-line-pos backward-word-pos)
	    (backward-delete-char (- cur-pos beg-of-line-pos))
	  (backward-kill-word 1))))))
(global-set-key (kbd "M-DEL") 'elinx/delete-till-the-beginning-of-line)
