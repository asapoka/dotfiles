;;; gitignore-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (gitignore-mode) "gitignore-mode" "../../../../.emacs.d/elpa/gitignore-mode-20140605.520/gitignore-mode.el"
;;;;;;  "cdd9cfc157baaa75781197c044ee6c73")
;;; Generated autoloads from ../../../../.emacs.d/elpa/gitignore-mode-20140605.520/gitignore-mode.el

(autoload 'gitignore-mode "gitignore-mode" "\
A major mode for editing .gitignore files.

\(fn)" t nil)

(dolist (pattern (list "/\\.gitignore\\'" "/\\.git/info/exclude\\'" "/git/ignore\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitignore-mode)))

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/gitignore-mode-20140605.520/gitignore-mode-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/gitignore-mode-20140605.520/gitignore-mode.el")
;;;;;;  (21442 32206 684000 0))

;;;***

(provide 'gitignore-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; gitignore-mode-autoloads.el ends here
