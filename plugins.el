;;; plugins.el --- Summary

;;; Commentary:
;;; This contains plugin configs

;;; Code:
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

;;; Perspective mode
(persp-mode)
; Stolen from http://emacsrookie.com/2011/09/25/workspaces/
(defmacro custom-persp (name &rest body)
       `(let ((initialize (not (gethash ,name perspectives-hash)))
              (current-perspective persp-curr))
          (persp-switch ,name)
          (when initialize ,@body)
          (setq persp-last current-perspective)))
(defun custom-persp/code ()
  (interactive)
  (custom-persp "code"
  (projectile-switch-project)))

(defun custom-persp/emacs ()
  (interactive)
  (custom-persp "emacs"
                (find-file "~/.emacs.d/init.el")))

(define-key persp-mode-map (kbd "C-x p e") 'custom-persp/emacs)

(defun custom-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))

;; Easily switch to your last perspective
(define-key persp-mode-map (kbd "C-x x x") 'custom-persp-last)


;;; remember last position in file
;;; built-in package
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el"))
(setq-default save-place t)

;;; set all env vars from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;; monky - mercurial
(setq monky-process-type 'cmdserver)

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
  "," 'goto-last-change
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

;;; Helm
(helm-mode 1)
; helm in eshell
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map
                [remap eshell-pcomplete]
                'helm-esh-pcomplete)))
(add-hook 'eshell-mode-hook
           #'(lambda ()
               (define-key eshell-mode-map
                 (kbd "M-p")
                 'helm-eshell-history)))



(require 'cl)
(require 'tabbar-ruler)

;;; Smart mode line
(setq sml/hidden-modes '(" hl-p" " pair" " Undo-Tree" " yas" " Helm" " AC" " Guide" " Wrap" " vl"))
(setq sml/shorten-directory t)
(setq sml/shorten-modes t)
(setq sml/name-width 40)
(setq sml/mode-width 4)
(setq sml/theme 'respectful)
(sml/setup)

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
(setq projectile-completion-system 'grizzl)

;;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:complete-on-dot t)
(setq jedi:tooltip-method nil)
(defun jedi-config:setup-keys ()
      (local-set-key (kbd "M-.") 'jedi:goto-definition)
      (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
      (local-set-key (kbd "M-?") 'jedi:show-doc)
      (local-set-key (kbd "M-/") 'jedi:get-in-function-call))


;;; ipython
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

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
(global-flycheck-mode)

;;; bash completion
(require 'bash-completion)
(bash-completion-setup)

(provide 'plugins)
;;; plugins.el ends here
