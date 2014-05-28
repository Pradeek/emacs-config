;;; general.el --- Summary

;;; Commentary:
;;; This contains general Emacs configs

;;; Code:
;;; set command key to meta
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;;; wrap words properly
(global-visual-line-mode t)

;;; line numbers for everybody!
(global-linum-mode t)

;;; hide scroll bar and toolbar on GUI mode
(when (window-system)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

;;; hide welcome message
(setq inhibit-startup-message t)

;;; colorscheme
(load-theme 'flatland t)

;;; auto-indent
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(electric-indent-mode t)
;;; now disable it in org-mode
(add-hook 'org-mode-hook (lambda()
			   (set (make-local-variable 'electric-indent-functions)
				(list (lambda(arg) 'no-indent)))))


;;; show matching parens
(show-paren-mode 1)

;;; set font/font size
(set-frame-font "Source Code Pro-14")

;;; ask y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;; selected text must be overridden when typed over
(delete-selection-mode t)

;;; backup
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(provide 'general)
;;; general.el ends here
