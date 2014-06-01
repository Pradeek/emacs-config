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

;;; add colors to the shell
(setq ansi-color-names-vector
  ["black" "red" "green" "yellow" "PaleBlue" "magenta" "cyan" "white"])

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; fix unicode in terminal
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

;;; make dired better
(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(setq dired-recursive-deletes (quote top))
(define-key dired-mode-map (kbd "f") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "n") 'dired-create-directory)
(define-key dired-mode-map (kbd "M-r") 'dired-run-shell-command)
(define-key dired-mode-map (kbd "<") (lambda ()
                                       (interactive)
                                       (find-alternate-file "..")))

(provide 'general)
;;; general.el ends here
