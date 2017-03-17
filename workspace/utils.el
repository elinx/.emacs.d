;;; utils.el -- convenient functions

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

;; This file contains self developed functions for easy use of emacs

;;; Code:

;;; toggle beginning of line or fist char of current line by stroke "C-a"
(defun elinx/jump-to-beg-of-line-or-first-character()
  "jump to the beginning of line or the fist character of current line"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))


;;; kill region or current line by stroke "C-w"
(defun elinx/kill-region-or-current-line (beg end)
  "kill selected region or current line"
  (interactive "r")
  (if (region-active-p)
      (kill-region beg end)
    (kill-whole-line)))

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

(defun elinx/copy-region-or-current-line ()
  "copy current or active region to kill ring"
  (interactive)
  (if (region-active-p)
      (kill-ring-save nil nil t)
    (progn
      (kill-ring-save (line-beginning-position) (line-end-position))
      (message "Line Copied"))))

(provide 'utils)
