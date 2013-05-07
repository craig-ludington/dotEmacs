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
