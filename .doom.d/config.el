(setq user-full-name "zhou mingjun")
(setq user-mail-address "zhoumingjun@gmail.com")
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "sans"))
(setq doom-theme 'doom-dracula) ;; << This line enables the theme
(after! org
  (setq org-log-done 'note
        org-log-into-drawer t)

  ;; set org file directory
  (setq org-files-directory "~/org/")

  ;; set agenda files
  ;; (setq org-agenda-files (list org-files-directory))

  (setq org-agenda-files
    (apply 'append
      (mapcar
        (lambda (directory)
          (directory-files-recursively
            directory org-agenda-file-regexp))
              '("~/plan" ))))

  ;; Set different bullets, with one getting a terminal fallback.
  (setq org-superstar-headline-bullets-list
      '("☯" "☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷"))

  ;; set org
  (setq org-latex-default-packages-alist '(("" "xeCJK" t  ("xelatex")) ("AUTO" "inputenc" t  ("pdflatex")) ("T1" "fontenc" t  ("pdflatex")) ("" "graphicx" t) ("" "grffile" t) ("" "longtable" nil) ("" "wrapfig" nil) ("" "rotating" nil) ("normalem" "ulem" t) ("" "amsmath" t) ("" "textcomp" t) ("" "amssymb" t) ("" "capt-of" nil) ("hidelinks" "hyperref" nil))
))
  ;; (add-to-list 'org-latex-default-packages-alist '("" "xeCJK" t ("xelatex"))))

(use-package! org-projectile
   :after org
   :config
   (progn
     (org-projectile-per-project) ; strategy to use a separate .org file within each project
     (setq
      org-projectile-per-project-filepath "todo.org" ; use an .org file named <project>.org for each project
      org-agenda-files (append org-agenda-files (org-projectile-todo-files)) ; get .org file for all known projects & add to `org-agenda-files'
      )))

(use-package! ox-twbs)
(use-package ox-latex
  :defer t
  :init
  (setq org-latex-compiler "xelatex"))

(setq deft-directory "~/org/"
      deft-recursive t)
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-java-args (list "-Dhttp.proxyHost=127.0.0.1" "-Dhttp.proxyPort=1081" "-Dhttps.proxyHost=127.0.0.1" "-Dhttps.proxyPort=1081" "-Djava.awt.headless=true" "-jar" "--illegal-access=deny"))
(add-to-list 'org-babel-default-header-args:plantuml
             '((:java . -Dhttp.proxyHost=10.54.0.22 -Dhttp.proxyPort=3128 -Dhttps.proxyHost=10.54.0.22 -Dhttps.proxyPort=3128)))
(setq display-line-numbers-type t)
(setq which-key-idle-delay 0.01)
(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))
(setq +doom-dashboard-banner-padding '(0 . 2)
      +doom-dashboard-menu-sections
  '(("Reload last session"
     :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
     :when (cond ((require 'persp-mode nil t)
                 (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                 ((require 'desktop nil t)
                  (file-exists-p (desktop-full-file-name))))
     :face (:inherit (doom-dashboard-menu-title bold))
     :action doom/quickload-session)
    ("Open org-agenda"
     :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
     :when (fboundp 'org-agenda)
     :action org-agenda)
    ("Recently opened files"
     :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
     :action recentf-open-files)
    ("Open project"
     :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
     :action projectile-switch-project)
    ("Jump to bookmark"
     :icon (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
     :action bookmark-jump)
    ("Open private configuration"
     :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
     :when (file-directory-p doom-private-dir)
     :action doom/open-private-config)
    ("Open documentation"
     :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
     :action doom/help))
      +doom-dashboard-banner-file "emacs.svg"
      +doom-dashboard-banner-dir "~/.doom.d/"
)
(use-package! tramp
  :custom
  (tramp-use-ssh-controlmaster-options nil) ; Don't override SSH config.
  (tramp-default-method "ssh")    ; ssh is faster than scp and supports ports.
  (tramp-password-prompt-regexp   ; Add verification code support.
   (concat
    "^.*"
    (regexp-opt
     '("passphrase" "Passphrase"
       "password" "Password"
       "Verification code"
       "Login Ip:")
     t)
    ".*:\0? *")))
(add-hook! LaTeX-mode-hook
  (add-to-list TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX"
        TeX-save-query nil
        TeX-show-compilation t)
  (setq pdf-latex-command "xelatex"))
