;;
;; Setup environment group.
;;

(provide 'setup-environment)

(message "Setup environment group.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: nyan-mode                    ;;
;;                                       ;;
;; GROUOP: Environment -> Frames -> Nyan ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (load-user-file "nyan-mode-1.1.1/nyan-mode")
	(nyan-mode t)
	(display-warning "nyan-mode" "You'll need to install Nyan Mode manually." :warning)
  )

