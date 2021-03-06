;; PACKAGES
(package-initialize)
(setq package-check-signature nil) ;个别时候会出现签名校验失败
 (require 'package) ;; 初始化包管理器
 (unless (bound-and-true-p package--initialized) 
    (package-initialize)) ;; 刷新软件源索引
 (unless package-archive-contents
     (package-refresh-contents))

;;(setq default-directory "~/daily-nt/")

;; Add useful package repo
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/") t))
(unless (assoc-default "marmalade" package-archives)
  (add-to-list 'package-archives '("marmalade" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/")))
(unless (assoc-default "gnu" package-archives)
  (add-to-list 'package-archives '("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))


(unless (package-installed-p 'use-package) 
    (package-refresh-contents) 
    (package-install 'use-package))

(eval-and-compile 
    (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字 
    (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t 
    (setq use-package-always-demand nil) 
    (setq use-package-expand-minimally t) 
    (setq use-package-verbose t))
	
(add-to-list 'load-path 
    (expand-file-name (concat user-emacs-directory "lisp")))
;;

(setq custom-file 
    (expand-file-name "custom.el" user-emacs-directory))

(require 'custom-dong)
(require 'org-own)
(require 'init-ui)
(require 'lang-python)
(require 'lang-racket)
(require 'lang-haskell)
;;(require 'init-dashboard)
;;(require 'yasnippet-own)

; ; (eval-when-compile
; ; (require 'use-package))
; ; (setq use-package-verbose t)
; ; (setq use-package-always-ensure t)
; ; (setq warning-minimum-level :emergency)

;;Encoding and Envs
(prefer-coding-system 'utf-8)
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
(set-terminal-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

;; Font-config
;;(require 'cnfonts)
;; 让 cnfonts 随着 Emacs 自动生效。
;;(cnfonts-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cnfonts-set-spacemacs-fallback-fonts)
;; Auto generated by cnfonts
;; <https://github.com/tumashu/cnfonts>
; ; (set-face-attribute
 ; ; 'default nil
 ; ; :font (font-spec :name "-outline-Consolas-bold-italic-normal-mono-*-*-*-*-c-*-iso10646-1"
                  ; ; :weight 'normal
                  ; ; :slant 'normal
                  ; ; :size 10.0))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-outline-楷体-normal-normal-normal-mono-*-*-*-*-c-*-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 11.0)))
;;			 



			  
			  
			  
;;Tools strat -----------------------------------------------------

;;Undo Tree
(use-package undo-tree
  :ensure t
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)
    ))
;;
	  
;;Display Keybind
(use-package which-key
  :config
  (progn
    (which-key-mode)
    (which-key-setup-side-window-bottom)))

  ;;
;;Recent File
(use-package recentf
  :config
  (progn
    (setq recentf-max-saved-items 200
          recentf-max-menu-items 15)
    (recentf-mode)
    ))
;
;;Line number
(use-package linum
  :init
  (progn
    (global-linum-mode t)
    (setq linum-format "%4d  ")
      (set-face-background 'linum nil)
    ))

;;
;; Auto Pair Bracket
(use-package autopair
  :config (autopair-global-mode))
;;
;; Neotree Sidebar
(use-package neotree
  :custom
  (neo-theme 'nerd2)
  :config
  (progn
    (setq neo-smart-open t)
    (setq neo-theme (if (display-graphic-p) 'icons 'nerd))
    (setq neo-window-fixed-size nil)
    ;; (setq-default neo-show-hidden-files nil)
    (global-set-key [f2] 'neotree-toggle)
    (global-set-key [f8] 'neotree-dir)))
;;
;; Git tool
(use-package magit)
(use-package git-gutter+
  :ensure t
  :config
  (progn
    (global-git-gutter+-mode)))
;;



;;Smart Tab
(use-package smart-tab
  :config
  (progn
    (defun @-enable-smart-tab ()
      (smart-tab-mode))
    (add-hook 'prog-mode-hook '@-enable-smart-tab)
    ))
;;

;;Helm
; ; (use-package helm-swoop)
; ; (use-package helm-gtags)
; ; (use-package helm
  ; ; :diminish helm-mode
  ; ; :init
  ; ; (progn
    ; ; ;; (require 'helm-config)
    ; ; (setq helm-candidate-number-limit 100)
    ; ; ;; From https://gist.github.com/antifuchs/9238468
    ; ; (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          ; ; helm-input-idle-delay 0.01  ; this actually updates things
                                        ; ; ; reeeelatively quickly.
          ; ; helm-yas-display-key-on-candidate t
          ; ; helm-quick-update t
          ; ; helm-M-x-requires-pattern nil
          ; ; helm-ff-skip-boring-files t)
    ; ; (helm-mode))
  ; ; :config
  ; ; (progn
    ; ; )
  ; ; :bind  (("C-c s" . helm-swoop)
          ; ; ("C-x C-f" . helm-find-files)
          ; ; ("C-x b" . helm-buffers-list)
          ; ; ("M-y" . helm-show-kill-ring)
          ; ; ("M-x" . helm-M-x)))
;

;;Fuzzy Search
(use-package fiplr)

;;Smart move
; ; (use-package mwim
  ; ; :bind
  ; ; ("C-a" . mwim-beginning-of-code-or-line)
  ; ; ("C-e" . mwim-end-of-code-or-line))
;;




;;Tools end --------------------------------------------------------------



