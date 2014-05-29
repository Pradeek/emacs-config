;;; package --- Summary

;;; Commentary:
;;; This is my Emacs config

;;; Code:
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

;;; loads packages and activates them
(package-initialize)

(require 'cask "/usr/local/Cellar/cask/0.5.2/cask.el")
(cask-initialize)
(require 'pallet)

(add-hook 'after-init-hook '(lambda ()
 (load "~/.emacs.d/general.el")
 (load "~/.emacs.d/plugins.el")
 (load "~/.emacs.d/custom.el")
))

(provide 'init)
;;; init.el ends here
