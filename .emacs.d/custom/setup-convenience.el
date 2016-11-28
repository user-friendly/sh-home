;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup convenience group. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'setup-convenience)

(message "Setup convenience group.")

;; GROUP: Convenience -> Revert

;; update any change made on file to the current buffer
(global-auto-revert-mode)

;; GROUP: Convenience -> Ibuffer
(require 'ibuffer)

(defalias 'yes-or-no-p 'y-or-n-p)       ; y or n is enough
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
;; (add-hook 'after-init-hook 'global-company-mode)

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
;;                            ;;
;; I consider it convenience. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)
