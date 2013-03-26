(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(abbrev-mode t)
 '(erc-autojoin-mode nil)
 '(erc-echo-timestamps t)
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT" "MODE")))
 '(erc-modules (quote (autoaway button completion irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring track)))
 '(erc-nick "craig")
 '(erc-server "localhost")
 '(erc-stamp-mode t)
 '(ibuffer-saved-filter-groups (quote (("files-only-by-mode" ("files-only-by-mode" (not name . "^\\*.*\\*$"))) ("WORK" ("CNUAPP" (saved . "cnuapp")) ("ERC" (saved . "erc")) ("EMACS LISP" (saved . "elisp"))))))
 '(ibuffer-saved-filters (quote (("cnuapp" ((filename . "^/export/web/"))) ("erc" ((mode . erc-mode))) ("elisp" ((mode . emacs-lisp-mode))))))
 '(ibuffer-show-empty-filter-groups nil)
 '(me\.alpheus/browser/remote-host "roshi")
 '(me\.alpheus/find-file-in-project-program "find /export/cnuapp -type f -print")
 '(me\.alpheus/remote-clipboard/host "roshi")
 '(revert-without-query nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "AntiqueWhite1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(mode-line ((((class color) (min-colors 88)) (:background "LightBlue3" :foreground "black" :box (:line-width -1 :style released-button))))))

(defalias 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(ido-mode)
(progn (set-background-color "black") (set-foreground-color "white"))
(display-time)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(add-to-list 'load-path "~/.emacs.d/site")
(require 'me-alpheus-find-file-in-project)
(load "cbl")
(load "cbl-psql") ;; order dependency -- needs cbl.el
(load "cbl-sql")
(load "bitlbee-hacks")
(load "fix")
(load "cnuapp-customization")
(load "key-bindings")
(require 'yaml-path)
(require 'me-alpheus-browser-remote-open)
(require 'me-alpheus-remote-clipboard)
