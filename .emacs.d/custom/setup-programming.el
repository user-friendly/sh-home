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
                   electric-pair-open-newline-between-pairs t)
			 ))

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
