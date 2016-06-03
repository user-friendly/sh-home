;; 
;; Proxy feature for nyan mode.
;; 

(provide 'nyan-mode)

(let ((feature-file  "~/.emacs.d/nyan-mode-1.1.1/nyan-mode.el"))
  (if (file-readable-p feature-file)
	  (load-file feature-file)
	(print (concat "File not found: `" feature-file  "`. Nyan Mode not installed!"))
	)
  )

