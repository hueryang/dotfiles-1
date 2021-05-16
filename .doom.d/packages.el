;; [[file:packages.org::*Wakatime][Wakatime:1]]
(package! wakatime-mode)
;; Wakatime:1 ends here

;; [[file:packages.org::*Evil Colemak][Evil Colemak:1]]
(package! evil-colemak-basics)
(package! evil-better-visual-line)
;; Evil Colemak:1 ends here

;; [[file:packages.org::*Firestarter][Firestarter:1]]
(package! firestarter)
;; Firestarter:1 ends here

;; [[file:packages.org::*Org Download][Org Download:1]]
(package! org-download
  :recipe (:host github
            :repo "abo-abo/org-download"))
;; Org Download:1 ends here

;; [[file:packages.org::*Org Protocol Updates][Org Protocol Updates:1]]
(package! org-protocol-capture-html
  :recipe (:host github
           :repo "alphapapa/org-protocol-capture-html"))
;; Org Protocol Updates:1 ends here

;; [[file:packages.org::*Org Noter][Org Noter:1]]
(package! org-noter)
;; Org Noter:1 ends here

;; [[file:packages.org::*Org kankan][Org kankan:1]]
(package! org-kanban)
;; Org kankan:1 ends here

;; [[file:packages.org::*Org Rifle][Org Rifle:1]]
(package! helm-org-rifle)
;; Org Rifle:1 ends here

;; [[file:packages.org::*Dockerfile Mode][Dockerfile Mode:1]]
(package! dockerfile-mode)
;; Dockerfile Mode:1 ends here

;; [[file:packages.org::*PKGBUILD Mode][PKGBUILD Mode:1]]
(package! pkgbuild-mode
  :recipe (:host github
            :repo "juergenhoetzel/pkgbuild-mode"))
;; PKGBUILD Mode:1 ends here

;; [[file:packages.org::*MELPA Helper][MELPA Helper:1]]
(package! package-lint)
(package! flycheck-package)
;; MELPA Helper:1 ends here

;; [[file:packages.org::*Doom][Doom:1]]
(package! emacs-snippets
  :recipe (:host github
           :repo "hlissner/emacs-snippets"
           :files ("*")))
;; Doom:1 ends here

;; [[file:packages.org::*Standard][Standard:1]]
(package! yasnippet-snippets
  :recipe (:host github
           :repo "AndreaCrotti/yasnippet-snippets"
           :files ("*")))
;; Standard:1 ends here

;; [[file:packages.org::*Misc][Misc:1]]
(package! sicp)
(package! w3m)
(package! ox-twbs)
;; Misc:1 ends here
