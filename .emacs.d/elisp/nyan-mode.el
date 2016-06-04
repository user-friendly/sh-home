;; 
;; Proxy feature for nyan mode.
;; 

(provide 'nyan-mode)

(if (not (load-user-file "nyan-mode-1.1.1/nyan-mode"))
	(display-warning "nyan-mode" "You'll need to install Nyan Mode manually." :warning)
  )
