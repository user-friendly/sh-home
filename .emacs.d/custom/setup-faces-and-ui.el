;;
;; Setup faces and UI group.
;;

(provide 'setup-faces-and-ui)

(message "Setup faces and UI group.")

(require 'color-theme)
(color-theme-initialize)
(color-theme-install (color-theme-jsc-dark))
