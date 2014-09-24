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
					(add-hook 'find-file-hook (lambda () 
												(linum-mode 1)
												)
							  )
					)
				  )

(require-and-init 'color-theme
				  nil
				  (lambda (feature)
					(print "Load color themes."))
				  )
(require-and-init 'color-theme_seldefcustom)

(require-and-init 'erc
				  ;; (lambda ()
				  ;; 	;; (print "Setup ERC.")
				  ;; 	;; (print "Setup ERC key bindings.")
				  ;; 	;; ;; Make C-c RET (or C-c C-RET) send messages instead of RET.
				  ;; 	;; (define-key erc-mode-map (kbd "RET") nil)
				  ;; 	;; (define-key erc-mode-map (kbd "C-c RET") 'erc-send-current-line)
				  ;; 	;; (define-key erc-mode-map (kbd "C-c C-RET") 'erc-send-current-line)
				  ;; 	)
				  )

(require-and-init 'whitespace)

(require-and-init 'dired
				  (lambda ()
					(print "Setup Dired")
					(setq dired-listing-switches "-lAh --group-directories-first")
					)
				  )
					

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

;; This init hook will (and should) run first.
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
 '(color-theme-selection "Arjen" nil (color-theme_seldefcustom))
 '(erc-interpret-mirc-color nil nil nil "Nice! It would be awesome to see some color for a change.")
 '(erc-hide-list '("JOIN" "PART" "QUIT"))
 '(inhibit-startup-screen t)
 '(tab-width 4)
 '(linum-format "%4d ")
 '(column-number-mode t)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
