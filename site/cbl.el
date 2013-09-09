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
  (save-excursion (previous-line) (cbl/get-current-line)))

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
  (insert "require 'pry'; Pry.config.color = false; Pry.config.pager = false; binding.pry; # FIXME!!! DO NOT COMMIT"))


(labels ((x (f n)
            (set-face-attribute 'default nil :height (funcall f (* n (face-attribute 'default :height))))))
  (defun cbl/font-size/increase () (interactive) (x 'ceiling 1.10))
  (defun cbl/font-size/decrease () (interactive) (x 'floor   0.90)))

(defun cbl/ruby/insert-commas-as-necessary ()
  "Insert commas after every item in an array or parenthesized list, or after every key/value pair in a hash.
If there's a superfluous comma after the last item (or key/value pair) that comma will be deleted."
  (interactive)
  (if (equal 'ruby-mode major-mode)
      (let ((begin (point))
	    (end   (- (save-excursion (forward-sexp) (point)) 2)))
	(destructuring-bind (type end-char)
	    (cdr (assoc (string (following-char)) '( ("{" . (:hash  "}"))
						     ("[" . (:array "]"))
						     ("(" . (:list  ")")))))
	  (cl-labels ((maybe-forward-sexp () 
					  "true iff we can forward-sexp"
					  (let ((r t))
					    (condition-case e
						(forward-sexp)
					      ('scan-error (if (string= (second e) "Containing expression ends prematurely")
							       (setq r nil))))
					    r))
		      (advance ()
			       "forward-sexp, once if processing an array or list, twice if processing a hash"
			       (if (maybe-forward-sexp)
				   (if (equal type :hash)
				       (maybe-forward-sexp)
				     t))))
	    (down-list)
	    (while (and (< (point) end)
			(advance))
	      (cond ((looking-at end-char))
		    ((looking-at ","))
		    (t (insert ",")
		       (incf end)
		       (backward-char))))
	    (when (looking-at ",")
	      (delete-char 1))
	    (buffer-substring-no-properties (point-min) (point-max)))))
    (message "Ruby mode required.")))

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
    (insert (apply 'concatenate 'string failures))))
