;;
;; Setup faces and UI group.
;;

(provide 'setup-faces-and-ui)

(message "Setup faces and UI group.")

;; you won't need any of the bar thingies
;; turn it off to save screen estate
(if (fboundp 'scroll-bar-mode) 
    (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) 
    (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) 
    (menu-bar-mode -1))

(add-hook 'after-init-hook 
          (lambda () 
            (require 'color-theme) 
            (color-theme-initialize) 
            (color-theme-install (color-theme-jsc-dark))) 
          (when (not (window-system)) ; On terminals, the default highlighting face is not legible.
            (set-face-attribute 'hl-line t 
                                :inherit nil 
                                :underline '(:color foreground-color 
                                                    :style line))))
