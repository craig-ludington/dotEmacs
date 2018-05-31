(defmacro i-lambda (&rest body)
  `(lambda nil (interactive) (progn ,@body)))

;; Kinesis Freestyle2 Blue
(global-set-key (kbd "<home>")      'beginning-of-defun)
(global-set-key (kbd "<end>")       'end-of-defun)

;; Right Alt key is just Alt, so use it like Control to avoid using left thumb
(global-set-key (kbd "A-b")         'backward-char)
(global-set-key (kbd "A-f")         'forward-char)
(global-set-key (kbd "A-g")         'ido-switch-buffer)
(global-set-key (kbd "A-s")         'save-buffer)

(global-set-key (kbd "<C-down>")    'beginning-of-buffer)   ;; Big rectangle above 0  now forward-paragraph
(global-set-key (kbd "M-s-d")       'end-of-buffer)         ;; Dock above - key

;; When not in paredit mode
(global-set-key (kbd "M-[")         'backward-sexp)         ;; "Web left arrow"
(global-set-key (kbd "M-]")         'forward-sexp)          ;; "Web right arrow"

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "M-[")     'paredit-backward) ;; "Web left arrow"
     (define-key paredit-mode-map (kbd "M-]")     'paredit-forward)  ;; "Web right arrow"
     (define-key paredit-mode-map (kbd "<prior>") 'mark-sexp)))      ;; "Page up"


(when (boundp 'key-chord-mode)
  (key-chord-define-global "1=" 'magit-status)
  (key-chord-define-global "fj" 'switch-window)
  (key-chord-define-global "]\\" (i-lambda
				       (save-excursion
					 (let ((begin (point)))
					   (set-mark-command nil)
					   (forward-sexp)
					   (kill-ring-save begin (point))
					   (message (format "Saved %s" (buffer-substring-no-properties begin (point)))))))))


(global-set-key (kbd "<next>")      'kill-ring-save)
(global-set-key (kbd "H-c")         'counsel-git)
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
(global-set-key (kbd "H-SPC")       'ace-jump-mode)
(global-set-key (kbd "H-<right>")   (i-lambda (shrink-window-horizontally -1)))
(global-set-key (kbd "H-<up>")      (i-lambda (shrink-window -1)))
(global-set-key (kbd "H-<left>")    'shrink-window-horizontally)
(global-set-key (kbd "H-<down>")    'shrink-window)
(global-set-key (kbd "H-g")         'helm-grep-do-git-grep)



