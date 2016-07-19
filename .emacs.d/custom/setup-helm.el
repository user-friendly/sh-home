;;;;;;;;;;;;;;;;;
;; Setup Helm. ;;
;;;;;;;;;;;;;;;;;

(provide 'setup-helm)

(message "Setup Helm.")

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

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

(when (executable-find "curl") 
  (setq helm-google-suggest-use-curl-p t))

;; Open helm buffer inside current window, not occupy whole other window.
(setq helm-split-window-in-side-p           t
      ;; Move to end or beginning of source when reaching top or bottom of source.
      helm-move-to-line-cycle-in-source     t
      ;; Search for library in `require' and `declare-function' sexp.
      helm-ff-search-library-in-sexp        t
      ;; Scroll 8 lines other window using M-<next>/M-<prior>
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

;; Enable helm mode.
(helm-mode 1)
