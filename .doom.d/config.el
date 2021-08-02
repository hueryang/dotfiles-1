;; [[file:~/.doom.d/config.org::*Set full name][Set full name:1]]
(setq user-full-name "zhou mingjun")
;; Set full name:1 ends here
;; [[file:~/.doom.d/config.org::*Set email address][Set email address:1]]
(setq user-mail-address "zhoumingjun@gmail.com")
;; Set email address:1 ends here
;; [[file:~/.doom.d/config.org::*Font][Font:1]]
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "sans"))
;; Font:1 ends here
;; [[file:~/.doom.d/config.org::*Theme][Theme:1]]
(setq doom-theme 'doom-dracula) ;; << This line enables the theme
;; Theme:1 ends here
;; [[file:~/.doom.d/config.org::*Set org-directory][Set org-directory:1]]
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
;; Set org-directory:1 ends here
;; [[file:~/.doom.d/config.org::*org plantuml][org plantuml:1]]
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-java-args (list "-Dhttp.proxyHost=127.0.0.1" "-Dhttp.proxyPort=1081" "-Dhttps.proxyHost=127.0.0.1" "-Dhttps.proxyPort=1081" "-Djava.awt.headless=true" "-jar" "--illegal-access=deny"))
;; org plantuml:1 ends here
;; [[file:~/.doom.d/config.org::*org latex][org latex:1]]
(setq org-latex-toc-command "\\tableofcontents \\clearpage")
;; org latex:1 ends here
;; [[file:~/.doom.d/config.org::*org export][org export:1]]
(setq org-export-allow-bind-keywords t)
(setq org-html-table-default-attributes
      '(:class "table table-striped" ))
;; org export:1 ends here
;; [[file:~/.doom.d/config.org::*org crypt][org crypt:1]]
(setq org-crypt-key "infraservice")
;; org crypt:1 ends here
;; [[file:~/.doom.d/config.org::*org roam][org roam:1]]
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;  :hook
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
;; org roam:1 ends here
;; [[file:~/.doom.d/config.org::*Line-number][Line-number:1]]
(setq display-line-numbers-type t)
;; Line-number:1 ends here
;; [[file:~/.doom.d/config.org::*which-key][which-key:1]]
(setq which-key-idle-delay 0.01)
;; which-key:1 ends here
;; [[file:~/.doom.d/config.org::*tabs][tabs:1]]
(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))
;; tabs:1 ends here
;; [[file:~/.doom.d/config.org::*dashboard][dashboard:1]]
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
;; dashboard:1 ends here
;; [[file:~/.doom.d/config.org::*Tramp][Tramp:1]]
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
;; Tramp:1 ends here
;; [[file:~/.doom.d/config.org::*latex][latex:1]]
(add-hook! LaTeX-mode-hook
  (add-to-list TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX"
        TeX-save-query nil
        TeX-show-compilation t)
  (setq pdf-latex-command "xelatex"))
;; latex:1 ends here
