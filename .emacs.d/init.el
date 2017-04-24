
;; emacs has a package manager with a base package repo (marmalade)
;; and a number of other repo's. Here we're dropping marmalade and
;; replacing it with melpa stable and melpa and adding orgmode. 
(require 'package)

;; use melpa
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; in order to use the emacs package manager first we need to initialize it.
(package-initialize)

;; here we're setting up use-package on top of package. use-package
;; adds a configuration language and additional functionality.

;; to understand what this variable controls put the cursor over the
;; variabe name and type C-h-f or directly invoke `describe-variable'
(setq use-package-always-ensure t)

;; this bootstraps use-package. if it's not installed invoke
;; `package-install' to install it.`
(when
    (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))


;;; now for the packages

;; really, emacs is all about coding. so here are some tools if you
;; ever want to do a little elisp coding.
(use-package f)
(use-package dash)
(use-package dash-functional)
(use-package m-buffer)

;; loads use-key-chord which loads key-cord, bind-key-chord, and adds
;; a :chord symbol for use-package.
(use-package use-package-chords
  :config (key-chord-mode 1))

;; stackoverflow is great but why leave emacs to search it?
(use-package sx
  :init (require 'bind-key)
  :config
  (bind-keys
   :prefix "C-c s"
   :prefix-map my-sx-map
   :prefix-docstring "Global keymap for SX."
   ("q" . sx-tab-all-questions)
   ("i" . sx-inbox)
   ("o" . sx-open-link)
   ("u" . sx-tab-unanswered-my-tags)
   ("a" . sx-ask)
   ("s" . sx-search)))

;; use magit as your git frontend from inside emacs. like most things
;; emacs there are a number of extensions for magit, and for git in
;; general. none are installed here because of the (hopefully)
;; unopinionated nature of this configuration.
(use-package magit
  :pin melpa-stable
  :commands magit-status magit-blame
  :init
  (setq magit-auto-revert-mode nil)
  (setq magit-last-seen-setup-instructions "1.4.0")
  :bind (("s-g" . magit-status)
         ("s-b" . magit-blame)))

;; some minor modes for editing off-brand files
(use-package thrift)
(use-package yaml-mode)
(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode))

;; the big kahuna for scala devs. this loads the dev version of ensime
;; and so requires an explicit reference to the snapshot version of
;; the sbt plugin. ensime will pull in sbt-mode and scala-mode
(use-package ensime
  :init
  (put 'ensime-auto-generate-config 'safe-local-variable #'booleanp)
  (setq
   ensime-startup-snapshot-notification nil
   ensime-startup-notification nil))

;; this adds ivy completions to projectile.
(use-package counsel-projectile
  :init
  (counsel-projectile-on))

(use-package persp-projectile
  :init (persp-mode))

;; projectile is a complete project management package.
(use-package projectile
  :diminish projectile-mode
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t)
  :config
  (projectile-global-mode))

;; simple non-contraversial customizations
(setq
 custom-file (expand-file-name "custom.el" user-emacs-directory)
 load-prefer-newer t
 debug-on-error nil)

(f-touch (expand-file-name "custom.el" user-emacs-directory))
    	       
(load custom-file)

(server-start)

(add-hook 'scala-mode-hook
          (lambda ()
            (setq prettify-symbols-alist scala-mode-prettify-symbols)
            (prettify-symbols-mode)))

;;; end init.el
