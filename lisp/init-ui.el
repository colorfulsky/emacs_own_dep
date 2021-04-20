(provide 'init-ui)

;;Feature Mode
(display-time-mode 1)
(column-number-mode 1)
(show-paren-mode nil)
(display-battery-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(global-auto-revert-mode t)
(global-hl-line-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
;;(toggle-frame-fullscreen)

;;Titlebar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(let ((display-table (or standard-display-table (make-display-table))))
  (set-display-table-slot display-table 'vertical-border (make-glyph-code ?│)) ;; or ┃ │
  (setq standard-display-table display-table))
(set-face-background 'vertical-border (face-background 'default))
(set-face-foreground 'vertical-border "grey")

;;Doom Theme
 (setq custom-safe-themes t)

 ;;All the icons
(use-package all-the-icons
  :after memoize
  :load-path "site-lisp/all-the-icons")
  
;; doom theme enable
 (use-package doom-themes
   :config
   ;; Global settings (defaults)
   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
         doom-themes-enable-italic t) ; if nil, italics is universally disabled
   ;; Enable flashing mode-line on errors
   (doom-themes-visual-bell-config)

   (if (display-graphic-p)
       (progn
         ;; Enable custom neotree theme (all-the-icons must be installed!)
         (doom-themes-neotree-config)
         ;; or for treemacs users
         (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
         (doom-themes-treemacs-config)
         ))

   ;; Corrects (and improves) org-mode's native fontification.
   (doom-themes-org-config))

(if (string-equal system-type "darwin")
    (use-package darkokai-theme
      :ensure t
      :config (load-theme 'darkokai t))
  (use-package doom-themes
    :ensure t
    :config (load-theme 'doom-nord))
  )


;; nerd-icons
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/nerd-icons"))
;;(require 'nerd-icons)

;; modeline
(require 'all-the-icons)
(add-hook 'after-init-hook #'doom-modeline-mode)
 (use-package doom-modeline
   :ensure t
   :hook (after-init . doom-modeline-mode))

 (set-face-background 'mode-line nil)
 
;;Rainbow-mode
(use-package rainbow-mode
  :config
  (progn
    (defun @-enable-rainbow ()
      (rainbow-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow)
))
(use-package rainbow-delimiters
  :config
  (progn
    (defun @-enable-rainbow-delimiters ()
      (rainbow-delimiters-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow-delimiters)))

; ; (if (display-graphic-p)
    ; ; (progn
      ; ; (set-face-attribute 'default nil
                          ; ; :family "LigaSauceCodeProMedium Nerd Font"
                          ; ; :height 130
                          ; ; :weight 'Normal)
      ; ; (dolist (charset '(kana han symbol cjk-misc bopomofo))
        ; ; (set-fontset-font (frame-parameter nil 'font)
                          ; ; charset (font-spec :family "Microsoft Yahei"
                                             ; ; :size 11)))
      ; ; (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                     ; ; (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                     ; ; (36 . ".\\(?:>\\)")
                     ; ; (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                     ; ; (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                     ; ; (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
                     ; ; (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
                     ; ; (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
                     ; ; (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
                     ; ; (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
                     ; ; (48 . ".\\(?:x[a-zA-Z]\\)")
                     ; ; (58 . ".\\(?:::\\|[:=]\\)")
                     ; ; (59 . ".\\(?:;;\\|;\\)")
                     ; ; (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
                     ; ; (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
                     ; ; (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
                     ; ; (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
                     ; ; (91 . ".\\(?:]\\)")
                     ; ; (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
                     ; ; (94 . ".\\(?:=\\)")
                     ; ; (119 . ".\\(?:ww\\)")
                     ; ; (123 . ".\\(?:-\\)")
                     ; ; (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
                     ; ; (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
                     ; ; )
                   ; ; ))
        ; ; (dolist (char-regexp alist)
          ; ; (set-char-table-range composition-function-table (car char-regexp)
                                ; ; `([,(cdr char-regexp) 0 font-shape-gstring]))))
      ; ; )
	  ; ; )