(add-to-list 'load-path "~/.emacs.d/")
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-save-default nil)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(make-backup-files nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; yasnippet��u���Ă���t�H���_�Ƀp�X��ʂ�
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/elpa/yasnippet-20140617.1640"))

;;�����p�̃X�j�y�b�g�t�H���_�ƁC�E���Ă����X�j�y�b�g�t�H���_��2������Ă����܂��D
;;(��ɂ܂Ƃ߂Ă���������)
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/elpa/yasnippet-20140617.1640/snippets" 
                ))

;; yas�N��
(yas-global-mode 1)
