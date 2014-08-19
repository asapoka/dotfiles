;;; git-commit-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (git-commit-mode) "git-commit-mode" "../../../../.emacs.d/elpa/git-commit-mode-20140814.1435/git-commit-mode.el"
;;;;;;  "9a4016d5d14fa44fc9b660971e06ba51")
;;; Generated autoloads from ../../../../.emacs.d/elpa/git-commit-mode-20140814.1435/git-commit-mode.el

(autoload 'git-commit-mode "git-commit-mode" "\
Major mode for editing git commit messages.

This mode helps with editing git commit messages both by
providing commands to do common tasks, and by highlighting the
basic structure of and errors in git commit messages.

\(fn)" t nil)

(dolist (pattern '("/COMMIT_EDITMSG\\'" "/NOTES_EDITMSG\\'" "/MERGE_MSG\\'" "/TAG_EDITMSG\\'" "/PULLREQ_EDITMSG\\'")) (add-to-list 'auto-mode-alist (cons pattern 'git-commit-mode)))

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/git-commit-mode-20140814.1435/git-commit-mode-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/git-commit-mode-20140814.1435/git-commit-mode.el")
;;;;;;  (21491 21254 281000 0))

;;;***

(provide 'git-commit-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; git-commit-mode-autoloads.el ends here