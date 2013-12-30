(add-to-list 'load-path "~/.emacs.d/site")

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-mode t t)
 '(bm-cycle-all-buffers t)
 '(epa-file-name-regexp "\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'")
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(erc-autojoin-mode t)
 '(erc-away-timestamp-format "%T")
 '(erc-echo-timestamps t)
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT" "MODE")))
 '(erc-hide-timestamps nil)
 '(erc-modules (quote (autoaway button completion irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring track)))
 '(erc-nick "craigl")
 '(erc-prompt-for-password nil)
 '(erc-server "localhost")
 '(erc-stamp-mode t)
 '(erc-timestamp-format-left nil)
 '(erc-timestamp-format-right nil)
 '(exec-path (quote ("~/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(ibuffer-saved-filter-groups (quote (("files-only-by-mode" ("files-only-by-mode" (not name . "^\\*.*\\*$"))) ("WORK" ("CNUAPP" (saved . "cnuapp")) ("ERC" (saved . "erc")) ("EMACS LISP" (saved . "elisp"))))))
 '(ibuffer-saved-filters (quote (("cnuapp" ((filename . "^/export/web/"))) ("erc" ((mode . erc-mode))) ("elisp" ((mode . emacs-lisp-mode))))))
 '(ibuffer-show-empty-filter-groups nil)
 '(ido-use-filename-at-point t)
 '(ido-use-url-at-point t)
 '(magit-git-executable "/usr/local/bin/git")
 '(make-backup-files nil)
 '(me\.alpheus/browser/remote-host "craigl@roshi")
 '(me\.alpheus/find-file-in-project-program "find ~/opseng/acs -type f -print")
 '(me\.alpheus/remote-clipboard/host "craigl@roshi")
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(ns-right-alternate-modifier (quote alt))
 '(ns-right-command-modifier (quote hyper))
 '(revert-without-query nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Monaco"))))
 '(clj-special-face ((t (:foreground "DarkOrange1" :weight bold))) t)
 '(mode-line ((((class color) (min-colors 88)) (:background "LightBlue3" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(sh-heredoc ((t (:foreground "tan4")))))

(require 'erc-stamp)
(setq erc-password "narcolepsy")
(defalias 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(ido-mode)
(display-time)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(require 'ruby-mode)
(require 'yaml-path)
(require 'me-alpheus-browser-remote-open)
(require 'me-alpheus-remote-clipboard)
(require 'key-chord)
(key-chord-mode 1)
(require 'switch-window)
(require 'bm)

(require 'paredit)
(when (functionp 'paredit-join-sexps) 
  (defalias 'paredit-join-sexp
    'paredit-join-sexps
    "Hack for missing definition in paredit-everywhere-mode."))
(add-hook 'prog-mode-hook 'paredit-everywhere-mode)

(require 'me-alpheus-find-file-in-project)
(load "cbl")
(load "cbl-psql") ;; order dependency -- needs cbl.el
(load "cbl-sql")
(load "fix")
(load "key-bindings")
(require 'yaml-mode)
(load "me-alpheus-ido-window-configuration.el")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; multiple-cursors - https://github.com/magnars/s.el/issues/18
(defun string-prefix-p (prefix str &optional ignore-case)
  (let ((case-fold-search ignore-case))
    (string-match-p (format "^%s" (regexp-quote prefix)) str)))

(setenv "PATH" "/Users/craigl/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")
