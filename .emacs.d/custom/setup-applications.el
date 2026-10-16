;; -*- lexical-binding: t; -*-

;;
;; Setup application group.
;;

(provide 'setup-applications)

(message "Setup applications group.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: Erc               ;;
;;                            ;;
;; GROUP: Applications -> Erc ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'erc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: Calendar               ;;
;;                                 ;;
;; GROUP: Applications -> Calendar ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(appt-activate t)
