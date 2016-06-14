;;
;; Setup file group.
;;

(provide 'setup-files)

(message "Setup files group.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Dired              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired)

(setq dired-dwim-target t ; If another Dired buffer is visibpple in another window, use that directory as target for Rename/Copy.
      dired-listing-switches "-lAh"     ; Human-readable listing.
      )

;; Automatically refresh dired buffer on changes.
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; If it is not Windows, use the following listing switches.
(when (not (eq system-type 'windows-nt)) 
  (setq dired-listing-switches "-lha --group-directories-first"))

(require 'dired-x)                 ; Provide extra commands for Dired.

;; (define-key dired-mode-map "F" 'my-dired-find-file)
(defun my-dired-find-file 
    (&optional 
     arg)
  "Open each of the marked files, or the file under the point, or when prefix arg, the next N files " 
  (interactive "P") 
  (let* ((fn-list (dired-get-marked-files nil arg))) 
    (mapc 'find-file fn-list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Dired -> Wdired    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wdired allows you to edit a Dired buffer and write changes to disk
;; - Switch to Wdired by C-x C-q
;; - Edit the Dired buffer, i.e. change filenames
;; - Commit by C-c C-c, abort by C-c C-k
(require 'wdired)
(setq wdired-allow-to-change-permissions t ; allow to edit permission bits
      wdired-allow-to-redirect-links       ; allow to edit symlinks
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Recentf            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(recentf-mode)
(setq recentf-max-menu-items 30 recentf-max-saved-items 100)
