(windmove-default-keybindings)

(defmacro i-lambda (&rest body)
  `(lambda nil (interactive) (progn ,@body)))

(global-set-key (kbd "C-s")         'isearch-forward-regexp)
(global-set-key (kbd "C-M-s")       'isearch-forward)
(global-set-key (kbd "C-r")         'isearch-backward-regexp)
(global-set-key (kbd "C-M-r")       'isearch-backward)
(global-set-key (kbd "H-s")         'query-replace-regexp)
(global-set-key (kbd "s-s")         (i-lambda (shell (switch-to-buffer  "*shell*"))))
(global-set-key (kbd "s-k")         (i-lambda (kill-buffer nil)))
(global-set-key (kbd "s-0")         'delete-window)
(global-set-key (kbd "s-1")         'delete-other-windows)
(global-set-key (kbd "s-2")         'split-window-vertically)
(global-set-key (kbd "s-3")         'split-window-horizontally)
(global-set-key (kbd "s-;")         'comment-region)
(global-set-key (kbd "s-w")         'cbl/buffer-file-name)
(global-set-key (kbd "C-x C-b")     'helm-buffers-list)
(global-set-key (kbd "s-p")         'previous-buffer)
(global-set-key (kbd "s-n")         'next-buffer)
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
(global-set-key (kbd "s-r") (lambda () (interactive) (switch-to-buffer "*cljs-repl*")))
(global-set-key (kbd "s-t") (lambda () (interactive) (switch-to-buffer "*testrpc*")))
(global-set-key (kbd "H-g") 'helm-grep-do-git-grep)

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
(global-set-key (kbd "C-z") 'toggle-fullscreen)

(when (boundp 'key-chord-mode)

  (when (boundp '*me.alpheus/window/register-map*)
    (key-chord-define-global "ws" 'me.alpheus/window/save)
    (key-chord-define-global "wr" 'me.alpheus/window/restore)
    (key-chord-define-global "wk" 'me.alpheus/window/remove))

  (key-chord-define-global "1=" 'magit-status)
  (key-chord-define-global "fj" 'switch-window)

  (key-chord-define-global ".," (lambda () (interactive) (insert (uuid))))
  (key-chord-define-global "pc" 'projectile-commander)

  
  )

(defun key-chord-unset-global (keys)
  "Remove global key-chord of the two keys in KEYS."
  (interactive "sUnset key chord globally (2 keys): ")
  (key-chord-define (current-global-map) keys nil)) ;; Typo in the package: was (current-local-map)


