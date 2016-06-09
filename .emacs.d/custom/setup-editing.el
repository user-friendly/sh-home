;;
;; Setup editing group.
;;

(provide 'setup-editing)

(message "Setup editing group.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Editing -> Editing Basics ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq global-mark-ring-max 1000         ; increase mark ring entries
      mark-ring-max 1000                ; increase kill ring entries
      mode-require-final-newline t      ; add a newline to end of file
      )

;; default to 4 visible spaces to display a tab
(setq-default tab-width 4)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
;; This mode deletes a region if text is inserted.
(delete-selection-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Editing -> Killing ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq kill-ring-max 1000 ; increase kill-ring capacity
	  kill-whole-line t  ; if NIL, kill whole line and move the next line up
	  )
