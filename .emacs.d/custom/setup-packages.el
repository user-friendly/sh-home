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


  ;; anaphora           20140728.1536 installed             anaphoric macros providing implicit temp variables
  ;; async              20160513.128  installed             Asynchronous processing in Emacs
  ;; color-theme        20080305.34   installed             install color themes
  ;; dash               20160605.248  installed             A modern list library for Emacs
  ;; diff-hl            20160517.1631 installed             Highlight uncommitted changes using VC
  ;; drupal-mode        20160420.1258 installed             Advanced minor mode for Drupal development
  ;; drupal-spell       20130520.955  installed             Aspell extra dictionary for Drupal
  ;; elisp-format       20160508.252  installed             Format elisp code
  ;; epl                20150517.433  installed             Emacs Package Library
  ;; f                  20160426.527  installed             Modern API for working with files and directories
  ;; flycheck           20160606.302  installed             On-the-fly syntax checking
  ;; flyspell-correct   20160709.2233 installed             correcting words with flyspell via custom interface
  ;; flyspell-correc... 20160610.851  installed             correcting words with flyspell via helm interface
  ;; git-commit         20160519.950  installed             Edit Git commit messages
  ;; gitignore-mode     20160319.302  installed             Major mode for editing .gitignore files
  ;; helm               20160710.2350 installed             Helm is an Emacs incremental and narrowing framework
  ;; helm-core          20160710.2350 installed             Development files for Helm
  ;; helm-flycheck      20160710.129  installed             Show flycheck errors with helm
  ;; helm-flyspell      20160612.1640 installed             No description available.
  ;; helm-git           20120630.1403 installed             Helm extension for Git.
  ;; helm-git-files     20141212.517  installed             helm for git files
  ;; helm-git-grep      20160529.423  installed             helm for git grep, an incremental git-grep(1)
  ;; helm-gitignore     20150517.2056 installed             Generate .gitignore files with gitignore.io.
  ;; helm-gtags         20160417.555  installed             GNU GLOBAL helm interface
  ;; helm-ispell        20151231.53   installed             ispell-complete-word with helm interface
  ;; helm-ls-git        20160407.2140 installed             list git files.
  ;; helm-make          20160331.754  installed             Select a Makefile target with helm
  ;; helm-projectile    20160709.2315 installed             Helm integration for Projectile
  ;; js2-mode           20160620.1822 installed             Improved JavaScript editing mode
  ;; js2-refactor       20160525.113  installed             A JavaScript refactoring library for emacs.
  ;; let-alist          1.0.4         installed             Easily let-bind values of an assoc-list by their names
  ;; lorem-ipsum        20140911.1408 installed             Insert dummy pseudo Latin text.
  ;; magit              20160614.1158 installed             A Git porcelain inside Emacs
  ;; magit-filenotify   20151116.1540 installed             Refresh status buffer when git tree changes
  ;; magit-find-file    20150702.130  installed             completing-read over all files in Git
  ;; magit-popup        20160606.1041 installed             Define prefix-infix-suffix command combos
  ;; multiple-cursors   20160705.707  installed             Multiple cursors for Emacs.
  ;; php-mode           20160605.1533 installed             Major mode for editing PHP code
  ;; pkg-info           20150517.443  installed             Information about packages
  ;; popup              20160709.729  installed             Visual Popup User Interface
  ;; projectile         20160526.832  installed             Manage and navigate projects in Emacs easily
  ;; projectile-spee... 20150629.1153 installed             projectile integration for speedbar
  ;; rebox2             20121113.500  installed             Handling of comment boxes in various styles.
  ;; request            20160623.1938 installed             Compatible layer for URL request in Emacs
  ;; s                  20160508.2357 installed             The long lost Emacs string manipulation library.
  ;; seq                2.16          installed             Sequence manipulation functions
  ;; sr-speedbar        20150804.951  installed             Same frame speedbar
  ;; undo-tree          20140509.522  installed             Treat undo history as a tree
  ;; volatile-highli... 20160611.1855 installed             Minor mode for visual feedback on some operations.
  ;; web-mode           20160611.1226 installed             major mode for editing web templates
  ;; with-editor        20160408.201  installed             Use the Emacsclient as $EDITOR
  ;; workgroups2        20141102.1122 installed             New workspaces for Emacs
  ;; yasnippet          20160705.2039 installed             Yet another snippet extension for Emacs.
  
                  sr-speedbar
                  diff-hl
                  elisp-format
                  flycheck
                  flyspell-correct
                  flyspell-correct-helm
                  gitignore-mode
                  projectile
                  projectile-speedbar
                  helm
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
                  lorem-ipsum
                  magit
                  magit-filenotify
                  magit-find-file
                  php-mode
                  web-mode
                  js2-mode
                  js2-refactor
                  rebox2
                  undo-tree
                  workgroups2
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
      (package-install pkg)))
  )


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
                    nil t)
                   )
           )
     )
   )
  (if (package-desc-p pkg)
       (package-compute-transaction (list pkg)
                                    (package-desc-reqs pkg))
     (package-compute-transaction ()
                                  (list (list pkg)))
     )
  (setq package-list '(js2-mode js2-refactor))
  (package-download-transaction package-list)
  )
