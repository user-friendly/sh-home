;; Emacsen independent startup file.  All of the various installed
;; flavors of emacs (emacs 19, emacs 20, xemacs) will load this file
;; at startup.  Make sure any code you put here is emacs flavor
;; independent.

;; Package maintainers: do not have Debian packages edit this file.
;; See the policy manual for the proper way to handle Emacs package
;; initialization code.

;; Nice color themes:
;; Cooper Dark
;; Hober
;; Linh Dang Dark
;; Euphoria
;; Lethe
;; Midnight

;; Add and enable MELPA custom package archive.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
	     )
(package-initialize)

;; Add your modules path.
(add-to-list 'load-path "~/.emacs.d/custom/")

;; Load user modules.
(require 'user-utility)

;; Load setup modules.
(require 'setup-applications)
(require 'setup-communication)
(require 'setup-convenience)
(require 'setup-data)
(require 'setup-development)
(require 'setup-editing)
(require 'setup-environment)
(require 'setup-external)
(require 'setup-faces-and-ui)
(require 'setup-files)
(require 'setup-help)
(require 'setup-programming)
(require 'setup-text)
(require 'setup-local)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: workgroups2              ;;
;;                                   ;;
;; GROUP: Convenience -> Workgroups2 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'workgroups2)
;; Change workgroups session file
(setq wg-session-file "~/.emacs.d/.emacs_workgroups")
(workgroups-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (MAPC 'load (directory-files "~/.emacs.d/custom" t ".*\.el"))

;; (require-and-init 'linum
;; 				  (lambda ()
;; 					;; TODO How to get the symbol name of feature?
;; 					;;      Should be "linum".
;; 					(print "Setup linum.")
;; 					(add-hook 'find-file-hook (lambda () 
;; 												(linum-mode 1)
;; 												)
;; 							  )
;; 					)
;; 				  )

;; Add features.
(require 'erc)
(require 'whitespace)

;; (require-and-init 'google-c-style
;; 				  (lambda ()
;; 					(add-hook 'c-mode-common-hook 'google-set-c-style)
;; 					(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; 					)
;; 				  )

;; This init hook will (and should) run first.
;; (add-hook 'after-init-hook
;; 		  (lambda ()			
;; 			(print "Global key bindings.") 
;; 			(global-set-key (kbd "C-x C-b") 'ibuffer)
;; 			(global-set-key (kbd "C-c <left>") 'windmove-left)
;; 			(global-set-key (kbd "C-c <right>") 'windmove-right)
;; 			(global-set-key (kbd "C-c <up>") 'windmove-up)
;; 			(global-set-key (kbd "C-c <down>") 'windmove-down)
;; 			)
;; 		  )

