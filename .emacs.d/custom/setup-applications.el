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
(setq
 erc-auto-discard-away t
 erc-auto-set-away t
 erc-autoaway-idle-method 'user
 erc-autoaway-idle-seconds 1800
 erc-autoaway-message "Not paying attention to IRC..."
 erc-autoaway-mode t
 erc-away-nickname nil
 erc-away-timestamp-format "<%T>"
 erc-hide-list '("JOIN" "PART" "QUIT")
 erc-insert-timestamp-function 'erc-insert-timestamp-left-and-right
 erc-interpret-mirc-color '(nil nil nil "Nice! It would be awesome to see some color for a change.")
 erc-join-buffer 'bury
 erc-nick "plamen"
 erc-server-reconnect-timeout 10
 erc-timestamp-format "[%T]"
 erc-timestamp-format-right " [%T]"
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: Calendar               ;;
;;                                 ;;
;; GROUP: Applications -> Calendar ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(appt-activate t)
