;;; package --- Summary
;;; Commentary:
;;; Code:
(defun cbl/buffer-file-name ()
  "Message the buffer-file-name of the current buffer and put it in the kill-ring."
  (interactive)
  (let ((s (file-truename (buffer-file-name))))
    (kill-new s)
    (message "%s" s)))

(defun cbl/get-current-buffer ()
  "Return the text of the current buffer as a string."
  (buffer-substring-no-properties (point-min) (point-max)))

(defun cbl/get-current-line ()
  "Return the text of the current line as a string."
  (buffer-substring-no-properties (point-at-bol) (point-at-eol)))

(defun cbl/get-previous-line ()
  "Return the text of the previous line as a string. or nil if on the first line in the buffer"
  (save-excursion (if (< -1 (forward-line -1))
		      (cbl/get-current-line))))

(defun cbl/chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (replace-regexp-in-string (rx (or (: bos (* (any " \t\n")))
				    (: (* (any " \t\n")) eos)))
			    ""
			    str))

(defun cbl/text/indent-matching ()
  "Insert enough spaces to indent to the next column.  The next column is based on the previous line,
and is the column of the first non-space character on the previous line that is greater than the 
current column (on the current line).
Bugs: if you want to skip a column, you have to insert something, or press C-g."
  (interactive)
  (let* ((goal-column (save-excursion (previous-line)
				      (while (not (looking-at " ")) 
					(forward-char))
				      (while (looking-at " ")
					(forward-char))
				      (- (point) 
					 (point-at-bol))))
	 (goal-point (+ goal-column (point-at-bol))))
    (while (< (point) goal-point)
      (insert " "))))


(defun cbl/ruby/insert-pry ()
  (interactive)
  (insert "require 'pry-remote'; binding.remote_pry; # FIXME!!!"))


(labels ((x (f n)
            (set-face-attribute 'default nil :height (funcall f (* n (face-attribute 'default :height))))))
  (defun cbl/font-size/increase () (interactive) (x 'ceiling 1.10))
  (defun cbl/font-size/decrease () (interactive) (x 'floor   0.90)))

(defun cbl/highlight-region (begin end)
  (interactive "r")
  (let ((face (hi-lock-read-face-name))
	(overlay (make-overlay begin end)))
    (overlay-put overlay 'highlight-region-overlay t)
    (overlay-put overlay 'face face))
  (set-mark-command (point)))

(defun cbl/unhighlight-region (begin end)
  (interactive "r")
  (let ((face (hi-lock-read-face-name)))
    (remove-overlays (or begin (point-min)) (or end (point-max)) 'face face))
  (set-mark-command (point)))

(defun cbl/ruby/insert-commas-as-necessary ()
  "Insert commas after every item in an array or parenthesized list, or after every key/value pair in a hash.
If there's a superfluous comma after the last item (or key/value pair) that comma will be deleted."
  (interactive)
  (if (not (equal 'ruby-mode major-mode))
      (message "Ruby mode required.")
    (unless (member (string (following-char)) '("[" "{" "("))
      (up-list)
      (backward-sexp))

    (let ((begin (point))
	  (end   (- (save-excursion (forward-sexp) (point)) 2)))
      (destructuring-bind (type end-char)
	  (cdr (assoc (string (following-char)) '( ("{" . (:hash  "}"))
						   ("[" . (:array "]"))
						   ("(" . (:list  ")")))))
	(cl-labels ((maybe-forward-sexp () 
					"true iff we can forward-sexp"
					(when (< (point) end)
					  (let ((r t))
					    (condition-case e
						(forward-sexp)
					      ('scan-error (if (string= (second e) "Containing expression ends prematurely")
							       (setq r nil))))
					    r)))
		    (advance ()
			     "forward-sexp, once if processing an array or list, twice if processing a hash"
			     (if (maybe-forward-sexp)
				 (if (equal type :hash)
				     (maybe-forward-sexp)
				   t))))
	  (down-list)
	  (while (advance)
	    (cond ((looking-at end-char))
		  ((looking-at ","))
		  (t (insert ",")
		     (incf end)
		     (backward-char))))
	  (when (looking-at ",")
	    (delete-char 1))
	  (buffer-substring-no-properties (point-min) (point-max)))))))
 
;;; TESTS
(if 'nil
    (let ((failures '()))
      (cl-labels
	  ((cbl/ruby/insert-commas-as-necessary--test! 
	    (test-input expected)
	    (with-temp-buffer
	      "*commas*"
	      (ruby-mode)
	      (save-excursion (insert test-input))
	      (let ((actual (cbl/ruby/insert-commas-as-necessary)))
		(unless (equal expected actual)
		  (push (format "(equal '%s' '%s')\n" expected actual)
			failures))))))

	(cbl/ruby/insert-commas-as-necessary--test! "()"       "()")
	(cbl/ruby/insert-commas-as-necessary--test! "(a)"      "(a)")
	(cbl/ruby/insert-commas-as-necessary--test! "(a b)"    "(a, b)")
	(cbl/ruby/insert-commas-as-necessary--test! "(a, b)"   "(a, b)")
	(cbl/ruby/insert-commas-as-necessary--test! "(a b c)"   "(a, b, c)")
	(cbl/ruby/insert-commas-as-necessary--test! "(a b cx)"   "(a, b, cx)")
	(cbl/ruby/insert-commas-as-necessary--test! "(a b,)"   "(a, b)")

	(cbl/ruby/insert-commas-as-necessary--test! "[]"        "[]")
	(cbl/ruby/insert-commas-as-necessary--test! "[a]"       "[a]")
	(cbl/ruby/insert-commas-as-necessary--test! "[a,]"      "[a]") 
	(cbl/ruby/insert-commas-as-necessary--test! "[a b]"     "[a, b]")
	(cbl/ruby/insert-commas-as-necessary--test! "[a b c]"   "[a, b, c]")
	(cbl/ruby/insert-commas-as-necessary--test! "[a b cx]"  "[a, b, cx]")
	(cbl/ruby/insert-commas-as-necessary--test! "[a, b,]"   "[a, b]")

	(cbl/ruby/insert-commas-as-necessary--test! "{}"                           "{}")
	(cbl/ruby/insert-commas-as-necessary--test! "{:a => :b}"                   "{:a => :b}")
	(cbl/ruby/insert-commas-as-necessary--test! "{:a => :b :x => :y}"          "{:a => :b, :x => :y}")
	(cbl/ruby/insert-commas-as-necessary--test! "{:a => :b :x => :y :z => :a}" "{:a => :b, :x => :y, :z => :a}")
	(cbl/ruby/insert-commas-as-necessary--test! "{:a => :b :x => :y :z => a}"  "{:a => :b, :x => :y, :z => a}"))

      (when failures
	(insert "\n\nFAILURES:\n\n")
	(insert (apply 'concatenate 'string failures)))))

(defun cbl/basename ()
  (interactive)
  (replace-regexp-in-string "^.*/" "" (file-truename (buffer-file-name))))

(defun cbl/open-this-file ()
  (interactive)
  (shell-command (format "open %s" (file-truename (buffer-file-name)))))

(defun cbl/test-png (city)
  (interactive "sCity: ")
  (save-buffer)
  (shell-command "cd ~/src/kitty && rm -rf data out/* && sleep 1")
  (nrepl-load-file buffer-file-name)
  (nrepl-eval (format "(kitty.drive/trial \"%s\")" city))
  ;; (shell-command "cd ~/src/kitty && bin/png out/ $(find data -name '*.svg' -print); open out/*; open $(find data -name '*.svg')")
  (shell-command "cd ~/src/kitty &&  open $(find data -name '*.svg')")
  )


;; (nxml-attribute-local-name) if it's "tooltip" and the next token is "=" and 
;; (nxml-attribute-value)      the token following the = is this face, it's literal text.
;; Skip from <script> to </script>
;; Skip from <style> to </style>

(defun cbl/nxml/is-literal (text face)
  (and (equal '(nxml-text) face)
       (not (equal "%" text))
       (not (string-match-p "^{{.*}}" text))))

(defun cbl/nxml/get-literals ()
  (interactive)
  (assert (equal major-mode 'nxml-mode))
  (goto-char (point-min))
  (let ((collected '()))
    (while (not (eobp))
      (let* ((next-change  (or (next-property-change (point) (current-buffer))
			       (point-max)))
	     (text         (buffer-substring-no-properties (point) next-change))
	     (face         (get-text-property (point) 'face)))
	(when (cbl/nxml/is-literal text face)
	  ;; (message text)
	  (save-excursion (move-end-of-line nil) (insert (format " <!-- I18N '%s' -->" text)))
	  (push (format "%s:%d '%s'\n" buffer-file-name (line-number-at-pos) text) collected))
	(goto-char next-change)))
    (with-temp-file (format "%s.i18n" buffer-file-name)
	(dolist (x (nreverse collected))
	  (insert x)))
      (save-buffer)
    collected))

(defun cbl/nxml/next-literal ()
  (interactive)
  (assert (equal major-mode 'nxml-mode))
  (let (done)
    (while (and (not done) (not (eobp)))
      (let* ((next-change  (or (next-property-change (point) (current-buffer))
			       (point-max)))
	     (text         (buffer-substring-no-properties (point) next-change))
	     (face         (get-text-property (point) 'face)))
	(if (cbl/nxml/is-literal text face)
	    (progn
	      (message text)
	      (goto-char next-change)
	      (setq done t))
	  (goto-char next-change))))))

;;  #!/bin/bash
;;  # This is bqq
;;  input=$(cat -)
;;  echo "$input"
;;  echo
;;  /Users/craigl/google-cloud-sdk/bin/bq query "$@" "$input" | sed -n '1,2d;4d;$d;p'
(defun cbl/bigquery/execute ()
  "Execute the contents of the current buffer as a Big Query.  
Depends on a shell wrapper that formats the output of bq."
  (interactive)
  (let ((query (cbl/get-current-buffer))
	(tmp   (make-temp-file "bqq-")))
    (with-temp-buffer
      (insert query)
      (write-file tmp))
    (shell-command (format "~/bin/bqq --max_rows 1000000 < %s &" tmp) tmp)))

(defun cbl/markdown/escape-underscores (start end)
  (interactive "r")
  (save-excursion
    (message "first")
    (replace-regexp "\\([a-z]\\)-\\([a-z]\\)" "\\1_\\2" nil start end))
  (save-excursion
    (message "second")
    (replace-string "_" "\\_" nil start end)))

(defun cbl/ncms/add-uuid ()
  (interactive)
  (cbl/nxml/next-literal)
  (search-backward "<")
  (forward-char 2)
  (forward-sexp)
  (insert " data-ncms-uuid=\"\"")
  (backward-char)
  (insert (uuid))
  (goto-char (point-at-eol)))

(defun cbl/ncms/insert-uuid ()
  (interactive)
  (insert " data-ncms-uuid=\"\"" )
  (backward-char)
  (insert (uuid))
  (forward-char)
  (insert " "))

(defun cbl/git/highlight-gabo-ignores ()
  "GABO -- stupid stuff that was committed but should have been ignored."
  (interactive)
  (highlight-regexp "Modified   admin/admin.yaml" 'hi-red-b)
  (highlight-regexp "Modified   admin/conf.json" 'hi-red-b)
  (highlight-regexp "Modified   dispatch.yaml" 'hi-red-b)
  (highlight-regexp "Modified   martini-inject" 'hi-red-b)
  (highlight-regexp "Modified   server/app.yaml" 'hi-red-b)
  (highlight-regexp "Modified   server/conf.json" 'hi-red-b)
  (highlight-regexp "Modified   server/data/ncms-assets/ncms-admin.js" 'hi-red-b)
  (highlight-regexp "Modified   server/data/ncms-assets/ncms.css" 'hi-red-b)
  (highlight-regexp "Modified   server/data/ncms-assets/ncms.js" 'hi-red-b)
  (highlight-regexp "Modified   static-backend/background.yaml" 'hi-red-b)
  (highlight-regexp "Modified   static-backend/conf.json" 'hi-red-b))
;;; cbl.el ends here


