;;
;; Custom functions.
;;

(provide 'user-utility)

(defvar user-home-dir
  (getenv "HOME")
  "User home directory (environment variable $HOME's value)."
  )

;; TODO Is this function needed?
(defun load-user-file (f)
  "Load a file if it exists and is readable."
  (setq f-abs (format "%s/.emacs.d/%s.el" user-home-dir f))
  (if (file-readable-p f-abs)
      (load-file f-abs)
    (prog2
		(display-warning "load-user-file" (format "Failed to load file %s" f-abs) :warning)
		nil
      )
    )
  )

(defun load-start-up-files (start-up-dir)
  "Loads all files from a startup directory that have '.el' extensions."
  (setq start-up-files (directory-files start-up-dir t ".*\.el\\'"))
  (dolist (file start-up-files)
    (if (file-readable-p file)
		(load-file file)
      (prog2
		  (display-warning "load-user-file" (format "Failed to load file %s" file) :warning)
		  nil
		)
      )
    )
  )

(defun require-and-init (feature &optional init pre-require post-require)
  "Require a feature and on success, add init to the after-init-hook.
  
  Pre-require is a func and is always executed before require is called.
  Post-require is called before adding the init hook. If post-require
  is supplied and returns nil, the init hook will not be added to
  after-init-hook."

  ;; post-return - helper var for init hook setup
  (let (post-return)
    (setq post-return t)
    ;; Always fire the pre-require hook.
    (if (functionp pre-require) (funcall pre-require feature))
    ;; Require with the last arg to t disables errors and
    ;; returns nil on fail, list on success.
    (if (require feature nil t)
		(progn
		  ;; If there is a post hook,
		  (if (functionp post-require)
			  ;; call it and return its value.
			  (setq post-return (funcall post-require feature))
			)
		  (if (and post-return (functionp init))
			  (add-hook 'after-init-hook init)
			)
		  ;; Feature loaded, return True.
		  t)
      ;; Failed to load feature, return false.
      nil)
    )
  )

