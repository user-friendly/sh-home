;; Emacsen independent startup file.  All of the various installed
;; flavors of emacs (emacs 19, emacs 20, xemacs) will load this file
;; at startup.  Make sure any code you put here is emacs flavor
;; independent.

;; Package maintainers: do not have Debian packages edit this file.
;; See the policy manual for the proper way to handle Emacs package
;; initialization code.

(require 'linum)
(require 'color-theme)

(defun global-after-init ()
  "Runs after all init files are loaded."
  (message "Setup linum.")
  (global-linum-mode 1)
  (global-hl-line-mode t)
  (setq linum-format "%4d ")
  (setq column-number-mode t)
;  (message "Setup color theme.")
;  (color-theme-initialize)
;  (color-theme-charcoal-black)
  (message "Key bindings.")
  (global-set-key (kbd "C-x b") 'buffer-menu)
  (global-set-key (kbd "C-x C-b") 'switch-to-buffer)
  (global-set-key (kbd "C-x <left>") 'windmove-left)
  (global-set-key (kbd "C-x <right>") 'windmove-right)
  (global-set-key (kbd "C-x <up>") 'windmove-up)
  (global-set-key (kbd "C-x <down>") 'windmove-down)
)

(add-hook 'after-init-hook 'global-after-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
