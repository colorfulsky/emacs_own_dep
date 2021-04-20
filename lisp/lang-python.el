(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")

;;(setq python-shell-interpreter "D://Anaconda//python")

;;修正使用python-mode 
; ; (require 'python-mode)
; ; (autoload 'python-mode "python-mode" "Python Mode." t)
; ; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
; ; (add-to-list 'interpreter-mode-alist '("python" . python-mode))

; ; (setq-default
 ; ; py-shell-name          "ipython" ; \ Default value under Unices
 ; ; py-python-command      "ipython" ); /
 ; ; ;;py-python-command-args '("-i" "/absolute/path/to/manage.py" "shell_plus")
; ; (autoload 'company-mode "company" nil t)


;;
(use-package anaconda-mode
	:ensure t
	:init (add-hook 'python-mode-hook 'anaconda-mode)
	)
;;
; ; (use-package lpy
	; ; :ensure t
	; ; :config (add-hook 'python-mode-hook #'lpy-mode))
; ; ;;

























(provide 'lang-python)