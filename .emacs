;; Emacsen independent startup file.  All of the various installed
;; flavors of emacs (emacs 19, emacs 20, xemacs) will load this file
;; at startup.  Make sure any code you put here is emacs flavor
;; independent.

;; Package maintainers: do not have Debian packages edit this file.
;; See the policy manual for the proper way to handle Emacs package
;; initialization code.

(add-to-list 'load-path "~/.emacs.d/elisp/")

;; (add-hook 'after-init-hook 'global-after-init)

;; TODO Debian style of loading init el files from .emacs.d.
(defvar user-home-dir
  (getenv "HOME")
  "User home directory (environment variable $HOME's value)."
  )

(defun load-user-file (f)
  "Load a file if it exists and is readable."
  (setq f-abs (format "%s/.emacs.d/%s.el" user-home-dir f))
  (if (file-readable-p f-abs)
	  (load-file f-abs)
	  (prog2
		(display-warning "load-user-file" (format "Failed to load file %s" f-abs) :warning)
		nil
	  )
	)
  )

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

(require 'color-theme)
(require 'color-theme_seldefcustom)
(require 'erc)
(require 'whitespace)
(require 'dired)
(require 'ido)

(require-and-init 'google-c-style
				  (lambda ()
					(add-hook 'c-mode-common-hook 'google-set-c-style)
					(add-hook 'c-mode-common-hook 'google-make-newline-indent)
					)
				  )

(require 'nyan-mode)

;; This init hook will (and should) run first.
(add-hook 'after-init-hook
		  (lambda ()			
			(print "Global key bindings.") 
			(global-set-key (kbd "C-x C-b") 'ibuffer)
			(global-set-key (kbd "C-c <left>") 'windmove-left)
			(global-set-key (kbd "C-c <right>") 'windmove-right)
			(global-set-key (kbd "C-c <up>") 'windmove-up)
			(global-set-key (kbd "C-c <down>") 'windmove-down)
			)
		  )

(setq custom-file "~/.emacs-custom.el")
(load custom-file)
