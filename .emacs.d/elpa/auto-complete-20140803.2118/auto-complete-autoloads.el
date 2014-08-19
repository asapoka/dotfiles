;;; auto-complete-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (global-auto-complete-mode auto-complete-mode auto-complete)
;;;;;;  "auto-complete" "../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete.el"
;;;;;;  "7e4cb7cd10e2b7c4ebe165be8557c2c2")
;;; Generated autoloads from ../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete.el

(autoload 'auto-complete "auto-complete" "\
Start auto-completion at current point.

\(fn &optional SOURCES)" t nil)

(autoload 'auto-complete-mode "auto-complete" "\
AutoComplete mode

\(fn &optional ARG)" t nil)

(defvar global-auto-complete-mode nil "\
Non-nil if Global-Auto-Complete mode is enabled.
See the command `global-auto-complete-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-auto-complete-mode'.")

(custom-autoload 'global-auto-complete-mode "auto-complete" nil)

(autoload 'global-auto-complete-mode "auto-complete" "\
Toggle Auto-Complete mode in all buffers.
With prefix ARG, enable Global-Auto-Complete mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Complete mode is enabled in all buffers where
`auto-complete-mode-maybe' would do it.
See `auto-complete-mode' for more information on Auto-Complete mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (ac-config-default) "auto-complete-config" "../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete-config.el"
;;;;;;  "4b85604161aa7c344fac4c04e6c89d0d")
;;; Generated autoloads from ../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete-config.el

(autoload 'ac-config-default "auto-complete-config" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete-config.el"
;;;;;;  "../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/auto-complete-20140803.2118/auto-complete.el")
;;;;;;  (21491 21257 351000 0))

;;;***

(provide 'auto-complete-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; auto-complete-autoloads.el ends here
