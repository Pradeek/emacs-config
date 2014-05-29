;;; package --- Summary

;;; Commentary:
;;; This file contains custom functions

;;; Code:

;;; python setup
(defun python-add-breakpoint ()
  "Add a break point."
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()"))
(add-hook 'python-mode-hook
     '(lambda () (define-key python-mode-map "\C-c\C-b" 'python-add-breakpoint)))

(defun select-current-line ()
  "Select the current line."
  (interactive)
  (end-of-line)
  (push-mark (line-beginning-position) nil t))

(defun line-above()
  "Create a line above the current line"
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun cut-line-or-region()
  "Cut region if something is selected, else cut current line"
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position) (line-beginning-position 2))))

(defun copy-line-or-region()
  "Copy region if something is selected, else copy current line"
  (interactive)
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position) (line-beginning-position 2))))

;;; Custom remappings
;;; aliases
(global-set-key (kbd "C-q") 'keyboard-quit) ; alias for C-g
(global-set-key (kbd "C-p") 'yank) ; alias for C-y

;;; custom function mappings
(global-set-key (kbd "C-o") 'line-above)
(global-set-key (kbd "C-l") 'select-current-line)
(global-set-key [remap kill-region] 'cut-line-or-region)
(global-set-key [remap kill-ring-save] 'copy-line-or-region)

(provide 'custom)
;;; custom.el ends here
