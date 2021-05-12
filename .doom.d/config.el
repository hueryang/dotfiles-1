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

(setq org-agenda-files (apply 'append
  (mapcar
  (lambda (directory)
  (directory-files-recursively
    directory org-agenda-file-regexp))
       '("~/org/todo/" ))))

  ;; Set different bullets, with one getting a terminal fallback.
  (setq org-superstar-headline-bullets-list
    '("☯" "☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷")))

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


(setq deft-directory "~/org/"
      deft-recursive t)
(use-package! org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "0.0.0.0"
        org-roam-server-port 8000
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)

  (defun org-roam-server-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (org-roam-server-mode 1)
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))))
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
    ("Open org-brain"
     :icon (all-the-icons-faicon "sitemap" :face 'doom-dashboard-menu-title)
     :when (fboundp 'org-brain-visualize)
     :action org-brain-visualize)
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
(map! :leader
   (:prefix-map ("o" . "open")
     :desc "Org brain"       "B"  #'org-brain-visualize

   ))
(map! "M-p" #'ivy-switch-buffer )
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
;; Load it
(use-package! wolfram-mode
  :config
  (setq mathematica-command-line "wolframscript")
  (setq wolfram-path "~/.WolframEngine")
  (add-to-list 'org-src-lang-modes '("mathematica" . wolfram)))

