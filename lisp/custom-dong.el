(provide 'custom-dong)

;;---------------------------------------------editting setting---------------------------------
;;搜索查找强化
(use-package ivy 
  :defer 1 
  :demand 
  :hook (after-init . ivy-mode) 
  :config 
  (ivy-mode 1) 
  (setq ivy-use-virtual-buffers t 
        ivy-initial-inputs-alist nil 
        ivy-count-format "%d/%d " 
        enable-recursive-minibuffers t 
        ivy-re-builders-alist '((t . ivy--regex-ignore-order)))) 
		
(use-package counsel 
  :after (ivy) 
  :bind (("M-x" . counsel-M-x) 
         ("C-x C-f" . counsel-find-file) 
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git))) 

(use-package swiper 
  :after ivy 
  :bind (("C-s" . swiper) 
         ("C-r" . swiper-isearch-backward)) 
  :config (setq swiper-action-recenter t 
                swiper-include-line-number-in-search t))

				
;;补全强化
(use-package company 
  :init (global-company-mode)
  (bind-key  "C-j"  #'company-select-next  company-active-map)
  (bind-key "C-k" #'company-select-previous company-active-map)
  :config 
  (setq company-dabbrev-code-everywhere t 
        company-dabbrev-code-modes t 
        company-dabbrev-code-other-buffers 'all 
        company-dabbrev-downcase nil 
        company-dabbrev-ignore-case t 
        company-dabbrev-other-buffers 'all 
        company-require-match nil 
        company-minimum-prefix-length 2 
        company-show-numbers t 
        company-tooltip-limit 20 
        company-idle-delay 0 
        company-echo-delay 0 
        company-tooltip-offset-display 'scrollbar 
        company-begin-commands '(self-insert-command)) 
  (push '(company-semantic :with company-yasnippet) company-backends) 
  ;;:hook ((after-init . global-company-mode))
  ;;:commands global-company-mode
  )


;; 窗口移动
(use-package windmove
  :bind
  (("M-j" . windmove-left)
  ("M-i" . windmove-up)
  ("M-k" . windmove-down)
  ("M-l" . windmove-right)))
	

  
;;选择增强及语法检查
(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck)

;;多光标编辑
(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))
  
;; Magit 设置
(use-package magit
  :config
  
  (setq magit-completing-read-function 'ivy-completing-read)
  
  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)
;;---------------------------------------------programming setting---------------------------------

;;                                     -----------------------------
;;												    LISP
;;									   -----------------------------

;;Lisp mode
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable (expand-file-name "~/.emacs.d/ccls"))
  )

;; (use-package eglot
  ;; :config
  ;; (add-hook 'prog-mode-hook 'eglot-ensure))

(use-package lsp-mode
  :ensure t
  :custom
  (lsp-enable-snippet t)
  (lsp-keep-workspace-alive t)
  (lsp-enable-xref t)
  (lsp-enable-imenu t)
  (lsp-enable-completion-at-point nil)

  :config  
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp)
  (add-hook 'rust-mode-hook #'lsp)
  (add-hook 'html-mode-hook #'lsp)
  (add-hook 'js-mode-hook #'lsp)
  (add-hook 'typescript-mode-hook #'lsp)
  (add-hook 'json-mode-hook #'lsp)
  (add-hook 'yaml-mode-hook #'lsp)
  (add-hook 'dockerfile-mode-hook #'lsp)
  (add-hook 'shell-mode-hook #'lsp)
  (add-hook 'css-mode-hook #'lsp)

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "pyls")
                    :major-modes '(python-mode)
                    :server-id 'pyls))
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.500) ;; default is 0.2
  ;;(require 'lsp-clients) 
  :commands lsp)

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

(use-package lsp-ui
  :ensure t
  :custom-face
  (lsp-ui-doc-background ((t (:background ni))))
  :init (setq lsp-ui-doc-enable t
              lsp-ui-doc-include-signature t               

              lsp-enable-snippet nil
              lsp-ui-sideline-enable nil
              lsp-ui-peek-enable nil

              lsp-ui-doc-position              'at-point
              lsp-ui-doc-header                nil
              lsp-ui-doc-border                "white"
              lsp-ui-doc-include-signature     t
              lsp-ui-sideline-update-mode      'point
              lsp-ui-sideline-delay            1
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-peek-always-show          t
              lsp-ui-flycheck-enable           nil
              )
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(setq lsp-prefer-capf t)

;;                                  -------------PYTHON------------
;;                                  -------------------------------

;;单独文件描述

;;                           ----------------other language setting-----------------------
;; Json Yaml Dockfile Protobuf 
(use-package json-mode)
(use-package yaml-mode)
(use-package dockerfile-mode)
(use-package protobuf-mode) 
 
;;-------------------------------------------Own functions---------------------------------------
;; Configure network proxy
(setq my-proxy "127.0.0.1:1080")
(defun show-proxy ()
  "Show http/https proxy."
  (interactive)
  (if url-proxy-services
      (message "Current proxy is \"%s\"" my-proxy)
    (message "No proxy")))

(defun set-proxy ()
  "Set http/https proxy."
  (interactive)
  (setq url-proxy-services `(("http" . ,my-proxy)
                             ("https" . ,my-proxy)))
  (show-proxy))

(defun unset-proxy ()
  "Unset http/https proxy."
  (interactive)
  (setq url-proxy-services nil)
  (show-proxy))

(defun toggle-proxy ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (unset-proxy)
    (set-proxy)))

	