;; Emacsen independent startup file.  All of the various installed
;; flavors of emacs (emacs 19, emacs 20, xemacs) will load this file
;; at startup.  Make sure any code you put here is emacs flavor
;; independent.

;; Package maintainers: do not have Debian packages edit this file.
;; See the policy manual for the proper way to handle Emacs package
;; initialization code.

(require 'linum)
(require 'whitespace)
(require 'color-theme)

;; TODO Debian style of loading init el files from .emacs.d.

;; (defvar user-home-dir
;;   (getenv "HOME")
;;   "User home directory (environment variable $HOME's value)."
;; )

;; (defun load-user-file (f)
;;   "Load a file if it exists. Fail silently if not."
;;   (setq f-abs (concat user-home-dir "/.emacs.d/" f ".el"))
;;   (if (file-exists-p f-abs)
;; 	  (load-file f-abs)
;; 	nil
;; 	)
;;   )

;; (load-user-file "10-color")

(defun global-after-init ()
  "Runs after all init files are loaded."

  (message "Setup linum.")
  (global-linum-mode 1)
  ;; Line number's format.
  (setq linum-format "%4d ")
  (setq column-number-mode t)

  ;; Hilight the line where the cursor currently is.
  (global-hl-line-mode t)

  (message "Init color themes.")
  (color-theme-initialize)
  ;; TODO Have the color theme be local, in .emacs.d.
  ;; Maybe two different types - NNX-name.el, NNT-name.el
  ;; where NN is a priority number, X|T is either for GUI (X) or Terminal,
  ;; optional. X will only be included/loaded if there is a GUI.
  ;; T will only be included/loaded if using a Terminal.
  ;; If neither X or T, loads file regardless of interface.
  (color-theme-arjen)
  ;; (color-theme-cooper-dark)
  ;; (color-theme-dark-laptop)

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
 '(inhibit-startup-screen t)
 '(tab-width 4))
