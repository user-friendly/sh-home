;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto install packages. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'setup-packages)

(message "Setup packages.")

;; Add and enable MELPA custom package archive.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(let ((packages '(
                  color-theme
                  company
                  diff-hl
;;                  drupal-mode
;;                  drupal-spell
                  elisp-format
                  flycheck
                  flyspell-correct
                  flyspell-correct-helm
                  flycheck-tip
;;                  flycheck-popup-tip
                  flycheck-pos-tip
                  expand-region
;;                  git-commit
                  gitignore-mode
                  helm
                  helm-core
                  helm-flycheck
                  helm-flyspell
                  helm-git
                  helm-git-files
                  helm-git-grep
                  helm-gitignore
                  helm-gtags
                  helm-ispell
                  helm-ls-git
                  helm-make
                  helm-projectile
                  js2-mode
                  js2-refactor
                  lorem-ipsum
                  magit
;;                  magit-filenotify
                  magit-find-file
                  magit-popup
                  multiple-cursors
                  php-mode
                  popup
                  projectile
                  projectile-speedbar
;;                  rebox2
                  sr-speedbar
                  undo-tree
                  volatile-highlights
                  web-mode
                  with-editor
                  workgroups2
                  yasnippet
                 )) 
      (refreshed nil)) 
  (when (not package-archive-contents) 
    (package-refresh-contents) 
    (setq refreshed t)) 
  (dolist (pkg packages) 
    (when (and (not (package-installed-p pkg)) 
               (assoc pkg package-archive-contents)) 
      (unless refreshed 
        (package-refresh-contents) 
        (setq refreshed t)) 
      (message "Installing package: %s" pkg) 
      (package-install pkg))))

(defun user-package-install (pkg)
  "Install the package PKG.
PKG can be a package-desc or the package name of one the available packages
in an archive in `package-archives'.  Interactively, prompt for its name."
  (interactive
   (progn
     ;; Initialize the package system to get the list of package
     ;; symbols for completion.
     (unless package--initialized
       (package-initialize t))
     (unless package-archive-contents
       (package-refresh-contents))
     (list (intern (completing-read
                    "Install packages: "
                    (delq nil
                          (mapcar (lambda (elt)
                                    (unless (package-installed-p (car elt))
                                      (symbol-name (car elt))))
                                  package-archive-contents))
                    nil t)))))
  (if (package-desc-p pkg)
       (package-compute-transaction (list pkg)
                                    (package-desc-reqs pkg))
     (package-compute-transaction ()
                                  (list (list pkg))))
  (setq package-list '(js2-mode js2-refactor))
  (package-download-transaction package-list))
