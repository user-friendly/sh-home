;;;;;;;;;;;;;;;;;
;; Setup Helm. ;;
;;;;;;;;;;;;;;;;;

(provide 'setup-helm)

(message "Setup Helm.")

(require 'helm)
(require 'helm-config)

;; Enable helm mode.
(helm-mode 1)

;; Rebind tab to do persistent action.
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; Make TAB works in terminal.
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;; List actions using C-z.
(define-key helm-map (kbd "C-z")  'helm-select-action)

;; Replace stock command execute with Helm's.
(global-set-key (kbd "M-x") 'helm-M-x)
;; Optional fuzzy matching for helm-M-x.
(setq helm-M-x-fuzzy-match t)
;; A fancier yank kill ring.
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; An even better buffer switcher.
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
