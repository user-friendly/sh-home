;;
;; Setup programming group.
;;

(provide 'setup-programming)

(message "Setup programming group.")

;; Lisp mode settings.
(add-hook 'emacs-lisp-mode-hook 
          '(lambda () 
             (show-paren-mode t) 
             (electric-pair-mode t) 
             (setq electric-pair-preserve-balance t
                   electric-pair-delete-adjacent-pairs t
                   electric-pair-open-newline-between-pairs t)))

;;
;; PHP/Web major modes settings.
;;

;; PHP Mode
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install\\'" . php-mode))

;; Web Mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: diff-hl                             ;;
;;                                              ;;
;; GROUP: Programming -> Tools -> Vc -> Diff Hl ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: elisp-format                       ;;
;;                                             ;;
;; GROUP: Programming -> Tools -> Elisp Format ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq elisp-format-column 78)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: flyckeck                       ;;
;;                                         ;;
;; GROUP: Programming -> Tools -> Flyckeck ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'flycheck)
(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 2)
(set-default 'flycheck-disabled-checkers '(emacs-lisp-checkdoc))
;; Enable flycheck-mode only for programming modes.
(add-hook 'prog-mode-hook 'flycheck-mode)

;; TODO Magit requires Git version >= 1.9.4.
;; Check for this requirment using Make.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: magit                       ;;
;;                                      ;;
;; GROUP: Programming -> Tools -> Magit ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'magit)
;; (set-default 'magit-stage-all-confirm nil)
;; (add-hook 'magit-mode-hook 'magit-load-config-extensions)

;; ;; full screen magit-status
;; (defadvice magit-status (around magit-fullscreen activate) 
;;   (window-configuration-to-register :magit-fullscreen)
;;   ad-do-it
;;   (delete-other-windows))

;; (global-unset-key (kbd "C-x g"))
;; (global-set-key (kbd "C-x g h") 'magit-log)
;; (global-set-key (kbd "C-x g f") 'magit-file-log)
;; (global-set-key (kbd "C-x g b") 'magit-blame-mode)
;; (global-set-key (kbd "C-x g m") 'magit-branch-manager)
;; (global-set-key (kbd "C-x g c") 'magit-branch)
;; (global-set-key (kbd "C-x g s") 'magit-status)
;; (global-set-key (kbd "C-x g r") 'magit-reflog)
;; (global-set-key (kbd "C-x g t") 'magit-tag)
