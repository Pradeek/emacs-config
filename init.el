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

(add-hook 'after-init-hook '(lambda ()
    (load "~/.emacs.d/general.el")
))

;;; ido-mode
(ido-mode 1)
(ido-everywhere 1)
;;; flx-ido plugin
(flx-ido-mode 1)
(setq ido-use-faces nil)

;;; show similar named files sanely
;;; built-in package
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;; remember last position in file
;;; built-in package
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el"))
(setq-default save-place t)

;;; set all env vars from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;; guide-key plugin
(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(guide-key-mode 1)

;;; evil mode
;;; vim in emacs ;) 
(require 'evil)
(evil-mode t)

;;; evil-leader
(global-evil-leader-mode 1)
(global-set-key (kbd "C-f") 'projectile-find-file)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states t)

(evil-leader/set-key
 ; "TAB" 'next-buffer
 ; "S-TAB" 'previous-buffer
  "TAB" 'tabbar-forward-tab
  "backtab" 'tabbar-backward-tab
  "e" 'evil-normal-state
  "f" 'projectile-find-file
  "F" 'projectile-switch-project
  "b" 'helm-buffers-list
  "g" 'ag-project
  "s" 'save-buffer
  "c" 'comment-or-uncomment-region
  "d" 'kill-this-buffer)

;;; ESC ALL THE THINGS = <C-g>
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;;; auto-complete plugin
(require 'auto-complete-config)
(ac-config-default)
(setq ac-sources '(
                   ac-source-yasnippet
                   ac-source-abbrev
                   ac-source-words-in-same-mode-buffers
                   ac-source-variables
                   ac-source-semantic
                   ac-source-dictionary
                   ;; ac-user-dictionary
                   ))

;;; tabbar / tabbar-ruler
(setq tabbar-ruler-global-tabbar t) ; If you want tabbar
(setq tabbar-ruler-popup-menu t) ; If you want a popup menu.
(setq tabbar-ruler-popup-toolbar t) ; If you want a popup toolbar
(setq tabbar-ruler-popup-scrollbar t) ; If you want to only show the
                                      ; scroll bar when your mouse is moving.

(helm-mode 1)

(require 'cl)
(require 'tabbar-ruler)

;;; Autopair
(autopair-global-mode)

;;; switch window
(global-set-key (kbd "C-x o") 'switch-window)
;;; skewer mode
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;;; scss mode
(setq scss-compile-at-save nil)
(setq scss-sass-options '("--cache-location" "'/tmp/.sass-cache'"))

;;; smex (better M-x)
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))



;;; yasnippet plugin
(yas-global-mode t)

;;; projectile mode
(projectile-global-mode)

;;; js2-mode 
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)) ;;; use it as major mode
(add-hook 'js2-mode-hook 'ac-js2-mode) ;;; autocomplete pls
(js2-imenu-extras-mode)

(setq js-basic-indent 2)
(setq-default js2-basic-indent 2)

(setq-default js2-basic-offset 2)
(setq-default js2-auto-indent-p t)
(setq-default js2-cleanup-whitespace t)
(setq-default js2-enter-indents-newline t)
(setq-default js2-indent-on-enter-key t)
(setq-default js2-mode-indent-ignore-first-tab t)

(defun disable-js2-checks()
  (interactive)
  (js2-mode-hide-warnings-and-errors))

(add-hook 'js2-mode-hook 'disable-js2-checks)

;; We'll let fly do the error parsing...
(setq-default js2-show-parse-errors nil)
(setq-default js2-mode-hide-warnings-and-errors t)

;;; set up flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)

;;; bash completion
(require 'bash-completion)
(bash-completion-setup)

;;; python setup

;; (defun python-add-breakpoint ()
;;   "Add a break point"
;;   (interactive)
;;   (newline-and-indent)
;;   (insert "import ipdb; ipdb.set_trace()")
;;   (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

;; (add-hook 'python-mode-hook
;;      '(lambda () (define-key python-mode-map "\C-c\C-b" 'python-add-breakpoint)))


;;; custom functions
(defun select-current-line ()
  "Selects the current line"
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
;;; Plugins used 
;;; =============
;;; 1. Expand region (Venture into Emacs - Ep 8)
;;; 2. Browse kill-ring (Venture into Emacs - Ep 8)
;;; 3. [Installed] flx ido mode (Venture into Emacs - Ep 9)
;;; 4. ace-jump (easymotion clone) (Venture into Emacs - Ep 10) 
;;; 5. [Installed] auto-complete (Venture into Emacs - Ep 13)
;;; 6. Cask (Vundle/NeoBundle clone) (Venture into Emacs - Ep 14)
;;; 7. [Installed] YASnippet (Custom LISP inside snippet OMG) (Venture into Emacs - Ep 15) (Rewatch this)
;;; 8. [Installed] Projectile (Venture into Emacs - Ep 16)
;;; 9. [Installed but not configured] Helm (Venture into Emacs - Ep 16)
;;; 10. [Installed] js2-mode
;;; 11. [Installed] ac-js2 (better autocomplete by ^^)
;;; 12. [Installed] evil
;;; 13. [Installed] evil-leader
;;; 14. [Installed] ag
;;; 15. [Installed] smex
;;; 16. [Installed] exec path from shell
;;; 17. [Installed] Tabbar-mode
;;; 18. [Installed] Tabbar-ruler
;;; 19. skewer-mode
;;; 20. [Installed] guide-key
;;; 21. [Installed] Autopair
;;; 22. [Installed] buffer-move
;;; 23. [Installed] switch-window
(provide 'init)
;;; init.el ends here