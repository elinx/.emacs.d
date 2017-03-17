;;; packages repositories
(require 'package)

(setq package-archives '(
			 ("gnu" . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa-emacs-china.org/melpa/")))

(package-initialize)

;;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized t)
;; (set-frame-parameter nil 'background-mode 'light)
(set-frame-parameter nil 'background-mode 'dark)


;;; yes => y, no => n
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)


;;; global setups
(global-linum-mode)


;;; package auto update or install
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

(install-packages)


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
;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


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


;;; mode line config
;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)
(setq sml/theme 'respectful)
(setq sml/no-confirm-load-theme t)
(sml/setup)


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
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative))
 '(save-place t nil (saveplace))
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
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight semi-bold :height 120 :width normal))))
 '(font-lock-type-face ((t (:foreground "#b58900")))))


;;; shell
(setq shell-file-name "/bin/bash")


;;; select beginning with stroking "M-SPC"
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; fullscreen
;; alias emacs=emacs -fs

;;; sr-speedbar
(require 'sr-speedbar)
(setq speedbar-use-images nil)
(setq speedbar-button-face nil)
(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)))
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))
(require 'projectile-speedbar)
(global-set-key (kbd "C-<f2>") 'projectile-speedbar-open-current-buffer-in-tree)
(set-face-attribute 'speedbar-button-face nil :height 90)

;;; frame parameters
;; (add-to-list 'default-frame-alist '(border-width . 0))
;; (add-to-list 'default-frame-alist '(internal-border-width . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(right-fringe . 0))
(add-to-list 'default-frame-alist '(left-fringe . 0))

(which-function-mode 1)

(require 'package)
(elpy-enable)

(nyan-mode t)
(prettify-symbols-mode t)

;;; customized functions
(add-to-list 'load-path "~/.emacs.d/workspace/")
(require 'main)
