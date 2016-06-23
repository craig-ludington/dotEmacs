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
   "(do (require 'weasel.repl.websocket) (cemerick.piggieback/cljs-repl (weasel.repl.websocket/repl-env :ip \"127.0.0.1\" :port 9001)))")
 '(cider-lein-command "~/bin/lein")
 '(cider-repl-display-help-banner nil)
 '(cider-repl-history-file "~/.cider-repl-history")
 '(cider-repl-use-clojure-font-lock nil)
 '(cider-repl-use-pretty-printing nil)
 '(clean-buffer-list-delay-special 60)
 '(clean-buffer-list-kill-regexps (quote (".asc$" ".gpg$")))
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
 '(midnight-mode t nil (midnight))
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(ns-right-alternate-modifier (quote alt))
 '(ns-right-command-modifier (quote hyper))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/")
     ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))))
 '(projectile-completion-system (quote ido))
 '(projectile-enable-caching t)
 '(projectile-file-exists-local-cache-expire 3600)
 '(projectile-indexing-method (quote native))
 '(read-quoted-char-radix 16)
 '(revert-without-query nil)
 '(save-interprogram-paste-before-kill nil)
 '(split-height-threshold 80))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Monaco"))))
 '(clj-special-face ((t (:foreground "DarkOrange1" :weight bold))) t)
 '(mode-line ((((class color) (min-colors 88)) (:background "LightBlue3" :foreground "black" :box (:line-width -1 :style released-button)))))
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
(require 'edit-server)
(edit-server-start)

(require 'midnight)
(defvar cbl/midnight/clean-buffer-list-timer (run-at-time nil 60 'clean-buffer-list)) ;; cancel-timer

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
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; (add-to-list 'auto-mode-alist '("\\.html$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljc$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.sol$" . javascript-mode))

;; (load "~/.emacs.d/site/ido-at-point/ido-at-point.el") ;; should get from melpa
;; (ido-at-point-mode) ;; C-M-i

;; ;; multiple-cursors - https://github.com/magnars/s.el/issues/18
;; (defun string-prefix-p (prefix str &optional ignore-case)
;;   (let ((case-fold-search ignore-case))
;;     (string-match-p (format "^%s" (regexp-quote prefix)) str)))

;; ;; (setenv "PATH" "/Users/craigl/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")
;; (setenv "GOPATH" "/Users/craigl/go_appengine/gopath")


;; ;; GOLANG
;; (require 'auto-complete)
;; (require 'go-autocomplete)
;; (require 'go-eldoc)
;; (add-hook 'go-mode-hook 'go-eldoc-setup)
;; (add-hook 'go-mode-hook (lambda () (local-set-key (kbd "M-.") #'godef-jump)))
;; (add-to-list 'load-path "~/.emacs.d/site/goflymake")
;; (require 'go-flycheck)
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; (helm-mode 1)
;; (projectile-mode 1)
(projectile-global-mode 1)
;; (helm-projectile-on)
(show-paren-mode)
(global-hi-lock-mode 1)


;; HACK because I don't understand defadvice, apparently
;; (defun cbl/projectile/filter-compiled-clojurescript (files)
;;   (if (string-match-p (rx string-start "/Users/craigl/raise/src/") (projectile-project-root))
;;       (remove-if (lambda (f)
;; 		   (string-match-p (rx string-start "resources/public/js/") f))
;; 		 files)
;;     files))
;;
;; (defadvice projectile-current-project-files (after filter-compiled-clojurescript (files))
;;   (cbl/projectile/filter-compiled-clojurescript files))
(defun projectile-current-project-files ()
  "Return a list of files for the current project."
  (let ((files (and projectile-enable-caching
                    (gethash (projectile-project-root) projectile-projects-cache))))
    ;; nothing is cached
    (unless files
      (when projectile-enable-caching
        (message "Empty cache. Projectile is initializing cache..."))
      (setq files (-mapcat #'projectile-dir-files
                           (projectile-get-project-directories)))
      ;; cache the resulting list of files
      (when projectile-enable-caching
        (projectile-cache-project (projectile-project-root) files)))

    (if (string-match-p (rx string-start "/Users/craigl/raise/src/") (projectile-project-root))
      (remove-if (lambda (f)
		   (string-match-p (rx string-start "resources/public/js/") f))
		 (projectile-sort-files files))
    (projectile-sort-files files))))

(defun client ()
  (interactive)
  (insert "(require 'app-server.client)\n(in-ns 'app-server.client)"))

(defun client-test ()
  (interactive)
  (insert "(require 'app-server.client-test)\n(in-ns 'app-server.client-test)"))

(defun run-client-test ()
  (interactive)
  (insert "(retailers-card-variants-cards-test)"))
