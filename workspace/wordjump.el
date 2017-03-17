;;; wordjump.el -- jump to word of current line

;; Copyright (C) 2017 Elinx Hsi

;; Author: Elinx Hsi <elinxxi@gmail.com>
;; Version: 0.1

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; There are many word/character jump package already, like ace-jump,
;; avy-jump, this file provide a more helm way to jump to the
;; beginning/end of a specifc word.

;;; Code:

(require 'helm)

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

(provide 'wordjump)
