;;; gitconfig-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (gitconfig-mode) "gitconfig-mode" "../../../../.emacs.d/elpa/gitconfig-mode-20140605.520/gitconfig-mode.el"
;;;;;;  "731579e719672c2aa835aec0ace53b30")
;;; Generated autoloads from ../../../../.emacs.d/elpa/gitconfig-mode-20140605.520/gitconfig-mode.el

(autoload 'gitconfig-mode "gitconfig-mode" "\
A major mode for editing .gitconfig files.

\(fn)" t nil)

(dolist (pattern '("/\\.gitconfig\\'" "/\\.git/config\\'" "/git/config\\'" "/\\.gitmodules\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitconfig-mode)))

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/gitconfig-mode-20140605.520/gitconfig-mode-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/gitconfig-mode-20140605.520/gitconfig-mode.el")
;;;;;;  (21442 32207 83000 0))

;;;***

(provide 'gitconfig-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; gitconfig-mode-autoloads.el ends here
