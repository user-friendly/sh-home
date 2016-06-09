;;
;; Setup environment group.
;;

(provide 'setup-environment)

(message "Setup environment group.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Environment -> Initialization ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 inhibit-startup-screen t
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Environment -> Mode Line    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(column-number-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: nyan-mode                    ;;
;;                                       ;;
;; GROUOP: Environment -> Frames -> Nyan ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq
 nyan-animate-nyancat t
 nyan-animation-frame-interval 0.5
 nyan-wavy-trail t
)
(if (load-user-file "nyan-mode-1.1.1/nyan-mode")
	(nyan-mode t)
	(display-warning "nyan-mode" "You'll need to install Nyan Mode manually." :warning)
  )

