;; Swap the isearch keys so that the regexp versions are the default
;; and the non-regexp versions are modified by the Meta key.
(global-set-key [(control      ?s)] 'isearch-forward-regexp)
(global-set-key [(control meta ?s)] 'isearch-forward)
(global-set-key [(control      ?r)] 'isearch-backward-regexp)
(global-set-key [(control meta ?r)] 'isearch-backward)

(global-set-key (kbd "s-;") 'comment-region)
(global-set-key [(H ?s)] 'query-replace-regexp)
(global-set-key [(s ?s)] (lambda () (interactive) (shell (switch-to-buffer  "*shell*"))))
(global-set-key [(s ?k)] (lambda () (interactive) (kill-buffer nil)))
(global-set-key [(s ?0)] 'delete-window)
(global-set-key [(s ?1)] 'delete-other-windows)
(global-set-key [(s ?2)] 'split-window-vertically)
(global-set-key [(s ?3)] 'split-window-horizontally)

(windmove-default-keybindings)

(global-set-key (kbd "H-f")         'me.alpheus/find-file-in-project)
(global-set-key (kbd "s-w")         'cbl/buffer-file-name)
(global-set-key (kbd "C-x C-b")     'ibuffer)
(global-set-key (kbd "C-c C-f")     'find-file-at-point)
(global-set-key (kbd "s-p")         'cbl/psql)
(global-set-key (kbd "s-m")         'magit-status)
(global-set-key (kbd "s-r")         'run-ruby)
(global-set-key (kbd "C-x SPC")     'just-one-space)
(global-set-key (kbd "s-SPC")       'cbl/text/indent-matching)
(global-set-key (kbd "H-SPC")       'ace-jump-mode)
(global-set-key (kbd "s-j")         'ace-jump-mode)
(global-set-key (kbd "H-r")         (lambda ()
				      (interactive)
				      (and (buffer-modified-p)
				           (revert-buffer nil :no-confirm)
				           (message "Reverted: %s" buffer-file-name))))

(global-set-key (kbd "H-<right>")   (lambda () (interactive) (shrink-window-horizontally -1)))
(global-set-key (kbd "H-<up>")      (lambda () (interactive) (shrink-window -1)))
(global-set-key (kbd "H-<left>")    'shrink-window-horizontally)
(global-set-key (kbd "H-<down>")    'shrink-window)


(add-hook 'yaml-mode-hook '(lambda () (define-key yaml-mode-map (kbd "C-c C-p") 'yaml-path/path)))

(global-set-key (kbd "C-c r")    'me.alpheus/browser/remote-open)