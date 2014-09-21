;; Emacsen independent startup file.  All of the various installed
;; flavors of emacs (emacs 19, emacs 20, xemacs) will load this file
;; at startup.  Make sure any code you put here is emacs flavor
;; independent.

;; Package maintainers: do not have Debian packages edit this file.
;; See the policy manual for the proper way to handle Emacs package
;; initialization code.

(add-to-list 'load-path "~/.emacs.d/elisp/")

;; (add-hook 'after-init-hook 'global-after-init)

(defun require-and-init (feature &optional init pre-require post-require)
  "Require a feature and on success, add init to the after-init-hook.
  
  Pre-require is a func and is always executed before require is called.
  Post-require is called before adding the init hook. If post-require
  is supplied and returns nil, the init hook will not be added to
  after-init-hook."

  ;; post-return - helper var for init hook setup
  (let (post-return)
	(setq post-return t)
	;; Always fire the pre-require hook.
	(if (functionp pre-require) (funcall pre-require feature))
	;; Require with the last arg to t disables errors and
	;; returns nil on fail, list on success.
	(if (require feature nil t)
		(progn
		  ;; If there is a post hook,
		  (if (functionp post-require)
			  ;; call it and return its value.
			  (setq post-return (funcall post-require feature))
			)
		  (if (and post-return (functionp init))
			  (add-hook 'after-init-hook init)
			)
		  ;; Feature loaded, return True.
		  t)
	  ;; Failed to load feature, return false.
	  nil)
  )
)


(require-and-init 'linum
				  (lambda ()
					;; TODO How to get the symbol name of feature?
					;;      Should be "linum".
					(print "Setup linum.")
					(global-linum-mode 1)
					;; Line number's format.
					(setq linum-format "%4d ")
					(setq column-number-mode t)
					)
				  )


(require-and-init 'color-theme
				  (lambda()
					(print "Init color themes.")
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
					)
				  )

(require-and-init 'erc
				  (lambda ()
					(print "Setup ERC.")
					(setq erc-hide-list '("JOIN" "PART" "QUIT"))
					(print "Setup ERC key bindings.")
					;; Make C-c RET (or C-c C-RET) send messages instead of RET.
					(define-key erc-mode-map (kbd "RET") nil)
					(define-key erc-mode-map (kbd "C-c RET") 'erc-send-current-line)
					(define-key erc-mode-map (kbd "C-c C-RET") 'erc-send-current-line)
					)
				  )

(require-and-init 'whitespace)

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

;; This init hook will run first.
(add-hook 'after-init-hook
		  (lambda ()

			;; Hilight the line where the cursor currently is.
			(global-hl-line-mode t)
			
			(print "Global key bindings.")
			(global-set-key (kbd "C-x b") 'buffer-menu)
			(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
			(global-set-key (kbd "C-x <left>") 'windmove-left)
			(global-set-key (kbd "C-x <right>") 'windmove-right)
			(global-set-key (kbd "C-x <up>") 'windmove-up)
			(global-set-key (kbd "C-x <down>") 'windmove-down)
			)
		  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-interpret-mirc-color nil nil nil "Nice! It would be awesome to see some color for a change.")
 '(inhibit-startup-screen t)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

