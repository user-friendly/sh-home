;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup convenience group. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'setup-convenience)

(message "Setup convenience group.")

(defalias 'yes-or-no-p 'y-or-n-p)       ; y or n is enough

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience -> Revert ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; update any change made on file to the current buffer
(global-auto-revert-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience -> Ibuffer ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)       ; always use ibuffer
(setq ibuffer-saved-filter-groups (quote (("Default" ("Helm" (used-mode .
                                                                        helm-major-mode)) 
                                           ("ERC" (used-mode . erc-mode)) 
                                           ("Text" (or (used-mode .
                                                                  fundamental-mode) 
                                                       (used-mode . org-mode) 
                                                       (filename .
                                                                 ".*\\.txt\\'"))) 
                                           ("Customization" (used-mode .
                                                                       Custom-mode)) 
                                           ("Dired" (used-mode . dired-mode)) 
                                           ("Help/Info" (or (used-mode .
                                                                       help-mode) 
                                                            (used-mode .
                                                                       Info-mode))) 
                                           ("Lisp" (or (filename .
                                                                 ".*\\.emacs\\'") 
                                                       (filename .
                                                                 ".*\\.el\\'"))) 
                                           ("PHP" (used-mode . php-mode)))))
      ibuffer-use-other-window t)
(add-hook 'ibuffer-mode-hook 
          (lambda () 
            (ibuffer-switch-to-saved-filter-groups "Default")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience -> Hippe Expand ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hippie-expand is a better version of dabbrev-expand.
;; While dabbrev-expand searches for words you already types, in current;; buffers and other buffers, hippie-expand includes more sources,
;; such as filenames, klll ring...
(global-set-key (kbd "M-/") 'hippie-expand) ;; replace dabbrev-expand
(setq
 hippie-expand-try-functions-list
 '(try-expand-dabbrev ;; Try to expand word "dynamically", searching the current buffer.
   try-expand-dabbrev-all-buffers ;; Try to expand word "dynamically", searching all other buffers.
   try-expand-dabbrev-from-kill ;; Try to expand word "dynamically", searching the kill ring.
   try-complete-file-name-partially ;; Try to complete text as a file name, as many characters as unique.
   try-complete-file-name ;; Try to complete text as a file name.
   try-expand-all-abbrevs ;; Try to expand word before point according to all abbrev tables.
   try-expand-list ;; Try to complete the current line to an entire line in the buffer.
   try-expand-line ;; Try to complete the current line to an entire line in the buffer.
   try-complete-lisp-symbol-partially ;; Try to complete as an Emacs Lisp symbol, as many characters as unique.
   try-complete-lisp-symbol) ;; Try to complete word as an Emacs Lisp symbol.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience -> HL Line ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq global-hl-line-sticky-flag t)
(global-hl-line-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience -> Linum ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook 'prog-mode-hook 'linum-mode) ;; enable linum only in programming modes
(global-linum-mode t)
(setq linum-format "%4d ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: company              ;;
;;                               ;;
;; GROUP: Convenience -> Company ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
;; The next 3 magical lines make company use Clang as it's backend.
(setq company-backends (delete 'company-semantic company-backends))
(add-hook 'c-mode-hook
          '(lambda ()
             (define-key c-mode-map  [(tab)] 'company-complete)
             ))
(add-hook 'c++-mode-hook
          '(lambda ()
             (define-key c++-mode-map  [(tab)] 'company-complete)
             ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: expand-region                       ;;
;;                                              ;;
;; GROUP: Convenience -> Abbreviation -> Expand ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES: projectile             ;;
;;                                  ;;
;; GROUP: Convenience -> Projectile ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(projectile-global-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: None.             ;;
;;                            ;;
;; GROUP: Convenience.        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)
