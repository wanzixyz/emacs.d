;;; init-local.el
;;; Commentary:
;;; Code:

;; undo-tree
(global-undo-tree-mode)

;; disable backup
(setq backup-inhibited t)

;; disable the gui.  Who uses emacs for toolbars and menus?
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq menu-prompting nil)

;; helm
(require 'helm-config)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(with-eval-after-load 'helm
  (define-key helm-map (kbd "<left>") 'helm-previous-source)
  (define-key helm-map (kbd "<right>") 'helm-next-source))
;; for helm-find-files
(customize-set-variable 'helm-ff-lynx-style-map t)

;; For helm-imenu
(customize-set-variable 'helm-imenu-lynx-style-map t)

;; for semantic
(customize-set-variable 'helm-semantic-lynx-style-map t)

;; for helm-occur
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)

;; for helm-grep
(customize-set-variable 'helm-grep-use-ioccur-style-keys t)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; nyan-mode
(nyan-mode t)
(nyan-start-animation)

;; disable auto save
(setq auto-save-default nil)

;; show line/column number
(setq column-number-mode t)

;; show parentheses
(show-paren-mode t)

;; ident
(global-set-key (kbd "RET") 'newline-and-indent) ; automatically indent when press RET
(global-set-key (kbd "C-c w") 'whitespace-mode) ; activate whitespace-mode to view all whitespace characters
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))  ;; show unncessary whitespace that can mess up your diff
(setq-default indent-tabs-mode nil) ; use space to indent by default
(setq-default tab-width 4); set appearance of a tab that is represented by 4 spaces

;; window movement
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-M-v") 'scroll-other-window)
(global-set-key (kbd "C-M-y") 'scroll-other-window-down)

;; remove linefeed flag
(global-visual-line-mode 1)

;; blank mode
;;(require 'blank-mode)
;;(setq blank-chars '(tabs trailing space-before-tab newline empty space-after-tab))
;;(setq blank-style '(color))

;; Package: projejctile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; Locate the helm-swoop folder to your path
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "C-c h o") 'helm-swoop)
(global-set-key (kbd "C-c s") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows t)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color t)

(require 'tern)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(add-hook 'after-init-hook 'global-company-mode)
(require 'company-tern)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-tern))

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(setenv "GOPATH" "/Users/iswallowyourring/work/gopath19")

;; M-}
;;(global-set-key (kbd "M-}") 'forward-paragraph)
;;(define-key m (kbd "M-}") 'forward-paragraph)

(provide 'init-local)

;; ggtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(add-hook 'python-mode-hook
          (lambda ()
            (when (derived-mode-p 'python-mode)
              (ggtags-mode 1))))

(add-hook 'go-mode-hook
          (lambda ()
            (when (derived-mode-p 'go-mode)
              (ggtags-mode 1))))

;; oxs-key-binding
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier nil))

;; text movement
(global-set-key (kbd "M-<right>") 'forward-word)
(global-set-key (kbd "M-<left>") 'backward-word)

;; font
(set-frame-font  "-*-Menlo-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
;;; init-local.el ends here
