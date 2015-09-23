;;; git-commit-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (git-commit-mode) "git-commit-mode" "../../../../.emacs.d/elpa/git-commit-mode-20141014.1634/git-commit-mode.el"
;;;;;;  "28b46c6a25ff55da7ca2c51e70105de0")
;;; Generated autoloads from ../../../../.emacs.d/elpa/git-commit-mode-20141014.1634/git-commit-mode.el

(autoload 'git-commit-mode "git-commit-mode" "\
Major mode for editing git commit messages.

This mode helps with editing git commit messages both by
providing commands to do common tasks, and by highlighting the
basic structure of and errors in git commit messages.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/MERGE_MSG\\'" . git-commit-mode))

(add-to-list 'auto-mode-alist '("/\\(?:COMMIT\\|NOTES\\|TAG\\|PULLREQ\\)_EDITMSG\\'" . git-commit-mode))

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/git-commit-mode-20141014.1634/git-commit-mode-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/git-commit-mode-20141014.1634/git-commit-mode.el")
;;;;;;  (21572 27568 394000 0))

;;;***

(provide 'git-commit-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; git-commit-mode-autoloads.el ends here