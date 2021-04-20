(provide 'org-own)

;;OrgMode
(setq org-todo-keywords 
      '((sequence "TODO(t)" "INPROGRESS(i@)" "WAITING(w@)" "REVIEW(r@)" "|" "DONE(d@)" "CANCELED(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("INPROGRESS" . "yellow")
        ("WAITING" . "purple")
        ("REVIEW" . "orange")
        ("DONE" . "green")
        ("CANCELED" .  "red"))
		)

(use-package org-bullets
  :ensure t
  :config
  (progn
    (setq org-bullets-bullet-list '("☯" "✿" "✚" "◉" "❀"))
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
    ))

(use-package org-alert
  :defer t
  :ensure t
  :config
  (progn
    (setq alert-default-style 'libnotify)
    ))

	

(use-package ido-completing-read+
   :ensure t
	)
	
;; define the var of source_temp
  ; ; (defvar org-modules
    ; ; '(org-tempo
      ; ; ))
(require 'org-tempo)
	
(defun @-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite" "html")))
     (list (ido-completing-read+ "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "\n#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code))
	)

;; roam-org
(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/daily-nt")
	  :config
	  (setq  org-roam-db-location "~/.emacs.d/org-roam.db"
	   org-roam-completion-system 'ivy)
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

; ; 搭建对应org-roam笔记模板
; ; 专业术语模板
; ; (add-to-list 'org-roam-capture-templates
             ; ; '("t" "Term" plain (function org-roam-capture--get-point)
               ; ; "- 领域: %^{术语所属领域}\n- 释义:"
               ; ; :file-name "%<%Y%m%d%H%M%S>-${slug}"
               ; ; :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
               ; ; :unnarrowed t
               ; ; ))
; ; 论文笔记模板
; ; (add-to-list 'org-roam-capture-templates
             ; ; '("p" "Paper Note" plain (function org-roam-capture--get-point)
               ; ; "* 相关工作\n\n%?\n* 观点\n\n* 模型和方法\n\n* 实验\n\n* 结论\n"
               ; ; :file-name "%<%Y%m%d%H%M%S>-${slug}"
               ; ; :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
               ; ; :unnarrowed t
               ; ; ))
;;org-roam-insert-immediate 对应模板修改
(setq org-roam-capture-immediate-template
      '("d" "default" plain (function org-roam-capture--get-point)
        "%?"
        :file-name "%<%Y%m%d%H%M%S>-${slug}"
        :head "#+title: ${title}\n"
        :unnarrowed t))

;; set org-roam-server 后续修正为use-package语法
(setq org-roam-server-host "127.0.0.1"
      org-roam-server-port 9090
      org-roam-server-export-inline-images t
      org-roam-server-authenticate nil
      org-roam-server-network-label-truncate t
      org-roam-server-network-label-truncate-length 60
      org-roam-server-network-label-wrap-length 20)
(org-roam-server-mode)
(require 'org-roam-protocol)


;; babel
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

;; ob-ipython 引用
(use-package ob-ipython)
(require 'ob-ipython)
;;(setq 'company-backends '())
;;(add-to-list 'company-backends 'company-ob-ipython)

;;设置Python执行路径
;;(setq org-babel-python-command "D://Anaconda//python")	
	
 (org-babel-do-load-languages
   'org-babel-load-languages
   '(;;(sh         . t)
   ; ; (js         . t)
		(emacs-lisp . t)
		(ipython . t)
		(haskell . t)
   ; ; (perl       . t)
   ; ; ;;(scala      . t)
   ; ; (clojure    . t)
		(python     . t)
   ; ; ;;(ruby       . t)
		(dot        . t)
   ; ; (css        . t)
		(sqlite   . t)
		(plantuml   . t)))
		
;;agenda view config
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

  (setq org-agenda-files '("D:\\Program Files (x86)\\org_daily\\org_daily.org"
                          ))
