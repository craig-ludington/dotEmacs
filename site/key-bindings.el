(windmove-default-keybindings)

(defmacro i-lambda (&rest body)
  `(lambda nil (interactive) (progn ,@body)))

(global-set-key (kbd "C-s")         'isearch-forward-regexp)
(global-set-key (kbd "C-M-s")       'isearch-forward)
(global-set-key (kbd "C-r")         'isearch-backward-regexp)
(global-set-key (kbd "C-M-r")       'isearch-backward)
(global-set-key (kbd "H-s")         'query-replace-regexp)
(global-set-key (kbd "s-s")         (i-lambda (shell (switch-to-buffer  "*shell*"))))
(global-set-key (kbd "s-s")         (i-lambda (shell (switch-to-buffer  "*shell*"))))
(global-set-key (kbd "s-k")         (i-lambda (kill-buffer nil)))
(global-set-key (kbd "s-0")         'delete-window)
(global-set-key (kbd "s-1")         'delete-other-windows)
(global-set-key (kbd "s-2")         'split-window-vertically)
(global-set-key (kbd "s-3")         'split-window-horizontally)
(global-set-key (kbd "s-;")         'comment-region)
(global-set-key (kbd "H-f")         'me.alpheus/find-file-in-project)
(global-set-key (kbd "s-w")         'cbl/buffer-file-name)
(global-set-key (kbd "C-x C-b")     'ibuffer)
(global-set-key (kbd "C-c C-f")     'find-file-at-point)
(global-set-key (kbd "s-p")         'cbl/psql)
(global-set-key (kbd "s-m")         (i-lambda (magit-status "/export/cnuapp")))
(global-set-key (kbd "s-r")         'run-ruby)
(global-set-key (kbd "C-x SPC")     'just-one-space)
(global-set-key (kbd "s-SPC")       'cbl/text/indent-matching)
(global-set-key (kbd "H-SPC")       'ace-jump-mode)
(global-set-key (kbd "s-j")         'ace-jump-mode)
(global-set-key (kbd "H-r")         (i-lambda
				      (and (buffer-modified-p)
				           (revert-buffer nil :no-confirm)
				           (message "Reverted: %s" buffer-file-name))))
(global-set-key (kbd "H-<right>")   (i-lambda (shrink-window-horizontally -1)))
(global-set-key (kbd "H-<up>")      (i-lambda (shrink-window -1)))
(global-set-key (kbd "H-<left>")    'shrink-window-horizontally)
(global-set-key (kbd "H-<down>")    'shrink-window)
(global-set-key (kbd "C-c r")       'me.alpheus/browser/remote-open)

(global-set-key (kbd "C-c c") 'me.alpheus/remote-clipboard/copy)
(global-set-key (kbd "C-c p") 'me.alpheus/remote-clipboard/paste)


(add-hook 'yaml-mode-hook '(lambda () (define-key yaml-mode-map (kbd "C-c C-p") 'yaml-path/path)))

(when (boundp 'key-chord-mode)
  (key-chord-define ruby-mode-map "[]" ;; #{} inside strings
		    (lambda ()
		      (interactive)
		      (if (equal 'font-lock-string-face (face-at-point))
			  (progn (insert "#{}")
				 (backward-char))
			(insert "[]"))))

  ;; Bookmarks
  (key-chord-define-global "bt" 'bm-toggle)
  (key-chord-define-global "bn" 'bm-next)
  (key-chord-define-global "bp" 'bm-previous)
  (key-chord-define-global "bs" 'bm-show-all)
  (key-chord-define-global "ba" 'bm-bookmark-annotate)

  (key-chord-define-global "fj" 'switch-window)
  )
