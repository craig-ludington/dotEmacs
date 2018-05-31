(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-mode t t)
 '(before-save-hook
   (quote
    ((lambda nil
       (and
	(equal major-mode
	       (quote clojure-mode))
	buffer-file-name
	(string-match "-"
		      (first
		       (nreverse
			(split-string buffer-file-name "/"))))
	(error "Hyphen in Clojure file name")))
     gofmt-before-save)))
 '(bm-cycle-all-buffers t)
 '(cider-cljs-lein-repl
   "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
 '(cider-lein-command "~/bin/lein")
 '(cider-repl-display-help-banner nil)
 '(cider-repl-history-file "~/.cider-repl-history")
 '(cider-repl-use-clojure-font-lock nil)
 '(cider-repl-use-pretty-printing nil)
 '(clean-buffer-list-delay-special 60)
 '(clean-buffer-list-kill-regexps (quote (".asc$" ".gpg$")))
 '(custom-safe-themes
   (quote
    ("dd2346baba899fa7eee2bba4936cfcdf30ca55cdc2df0a1a4c9808320c4d4b22" default)))
 '(dired-listing-switches "-l")
 '(edconf-exec-path
   "~/src/ncms/src/client/node_modules/editorconfig/bin/editorconfig")
 '(epa-file-name-regexp "\\.\\(asc\\|gpg\\)\\(~\\|\\.~[0-9]+~\\)?\\'")
 '(epa-file-select-keys t)
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(erc-autojoin-mode t)
 '(erc-away-timestamp-format "%T")
 '(erc-echo-timestamps t)
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT" "MODE")))
 '(erc-hide-timestamps nil)
 '(erc-modules
   (quote
    (autoaway button completion irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring track)))
 '(erc-nick "craigl")
 '(erc-prompt-for-password nil)
 '(erc-server "localhost")
 '(erc-stamp-mode t)
 '(erc-timestamp-format-left nil)
 '(erc-timestamp-format-right nil)
 '(exec-path
   (quote
    ("~/bin" "~/go_appengine/gopath/bin" "/usr/local/go/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(find-ls-option (quote ("-print0 | xargs -0 ls -ld" . "-ld")))
 '(flymake-gui-warnings-enabled nil)
 '(flymake-log-level 0)
 '(global-auto-revert-mode t)
 '(gofmt-command "goimports")
 '(ibuffer-saved-filter-groups
   (quote
    (("files-only-by-mode"
      ("files-only-by-mode"
       (not name . "^\\*.*\\*$")))
     ("WORK"
      ("CNUAPP"
       (saved . "cnuapp"))
      ("ERC"
       (saved . "erc"))
      ("EMACS LISP"
       (saved . "elisp"))))))
 '(ibuffer-saved-filters
   (quote
    (("cnuapp"
      ((filename . "^/export/web/")))
     ("erc"
      ((mode . erc-mode)))
     ("elisp"
      ((mode . emacs-lisp-mode))))))
 '(ibuffer-show-empty-filter-groups nil)
 '(ido-use-filename-at-point t)
 '(ido-use-url-at-point t)
 '(magit-git-executable "/usr/local/bin/git")
 '(magit-mode-hook (quote (cbl/git/highlight-gabo-ignores)))
 '(make-backup-files nil)
 '(me\.alpheus/browser/remote-host "craigl@roshi")
 '(me\.alpheus/find-file-in-project-program "find ~/go_appengine/gopath/src -name \\*.go")
 '(me\.alpheus/gotags-tags-file "~/go_appengine/GOTAGS")
 '(me\.alpheus/remote-clipboard/host "craigl@roshi")
 '(midnight-mode nil nil (midnight))
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(ns-right-alternate-modifier (quote alt))
 '(ns-right-command-modifier (quote hyper))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/")
     ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))))
 '(package-selected-packages
   (quote
    (counsel 0blayout auto-dim-other-buffers github-modern-theme alect-themes abyss-theme afternoon-theme zenburn-theme arjen-grey-theme align-cljlet helm-swoop flymake-solidity solidity-mode slack idle-highlight-mode paredit clojure-mode clojure-mode-extra-font-locking cider zoom-frm yasnippet yaml-mode unbound switch-window smartparens s paredit-menu paredit-everywhere names multiple-cursors markdown-mode magit litable key-chord inflections inf-ruby impatient-mode ido-vertical-mode ido-ubiquitous hydra helm-projectile go-errcheck go-eldoc go-direx go-autocomplete flycheck find-file-in-project etags-select emms edn editorconfig company-cider clj-mode cider-tracing cider-browse-ns bm aggressive-indent)))
 '(projectile-completion-system (quote ido))
 '(projectile-enable-caching t)
 '(projectile-file-exists-local-cache-expire 3600)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "resources/public/js" "resources/public/out" "resources/public/out2" "target")))
 '(projectile-indexing-method (quote native))
 '(read-quoted-char-radix 16)
 '(revert-without-query nil)
 '(safe-local-variable-values (quote ((eval orgtbl-mode t))))
 '(save-interprogram-paste-before-kill nil)
 '(scheme-program-name "chez")
 '(split-height-threshold 80)
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Monaco"))))
 '(auto-dim-other-buffers-face ((t (:background "gray32"))))
 '(clj-special-face ((t (:foreground "DarkOrange1" :weight bold))) t)
 '(mode-line ((t (:background "DodgerBlue3" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(sh-heredoc ((t (:foreground "tan4")))))

(require 'package)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/site")

(require 'erc-stamp)
(setq erc-password "narcolepsy")
(defalias 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(menu-bar-mode 1)
(tool-bar-mode -1)
(ido-mode)
(display-time)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

;; (require 'ruby-mode)
;; (require 'yaml-path)
;; (require 'me-alpheus-browser-remote-open)
;; (require 'me-alpheus-remote-clipboard)
(require 'key-chord)
(key-chord-mode 1)
(require 'switch-window)
(require 'bm)

(require 'paredit)
(require 'paredit-menu)
(when (functionp 'paredit-join-sexps) 
  (defalias 'paredit-join-sexp
    'paredit-join-sexps
    "Hack for missing definition in paredit-everywhere-mode."))
(add-hook 'prog-mode-hook 'paredit-everywhere-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook #'eldoc-mode)

;; clj-refactor-mode looks cool but causes clojure to run out of memory
;;
;; (defun my-clojure-mode-hook ()
;;     (clj-refactor-mode 1)
;;     (yas-minor-mode 1) ; for adding require/use/import statements
;;     ;; This choice of keybinding leaves cider-macroexpand-1 unbound
;;     (cljr-add-keybindings-with-prefix "s-r"))

;; (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; For editing in Chrome with Emacs
;; (require 'edit-server)
;; (edit-server-start)

(require 'dired-x)
(require 'find-dired)
(require 'uuid)
(require 'me-alpheus-find-file-in-project)

(load "cbl")
(load "cbl-psql") ;; order dependency -- needs cbl.el
(load "cbl-sql")
(load "fix")
(load "me-alpheus-ido-window-configuration.el")
(load "key-bindings")
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljc$" . clojurec-mode))
(add-to-list 'auto-mode-alist '("\\.sol$" . solidity-mode))
(projectile-global-mode 1)
(show-paren-mode)
(global-hi-lock-mode 1)

(load "git-dired") ;; order dependency -- needs projectile


;; M-x package-install <RETURN> idle-highlight-mode
(add-hook 'clojure-mode-hook 'idle-highlight-mode)
(defun cbl/apply-unless-point-inside-a-comment (original-function &rest args)
  (when (not (nth 4 (syntax-ppss)))
    (apply original-function args)))
(advice-add 'idle-highlight-word-at-point :around #'cbl/apply-unless-point-inside-a-comment)

(setenv "PATH"
	"/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9:/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9:/usr/local/bin")


;;  '(cider-cljs-lein-repl
;;    "(do (use 'figwheel-sidecar.repl-api) (load-file \"script/figwheel.clj\") #_#_(start-figwheel!) (cljs-repl))")
