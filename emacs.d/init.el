(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/org-contrib/")
(require 'org-checklist)

;; put backup files in the backup directory
(setq backup-directory-alist
	  `((".*" . "~/.emacs_backups")))
(setq auto-save-file-name-transforms
	  `((".*" "~/.emacs_backups" t)))
