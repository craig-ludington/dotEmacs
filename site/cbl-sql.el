(defun cbl/sql/move-to-next-keyword ()
  "Move point to the beginning of the next keyword or type.  Return the keyword if successful, nil otherwise."
  (interactive)
  (let (result)
    (while (and (not result)
		(< (point) (point-max)))
      (if (or (member 'font-lock-keyword-face (text-properties-at (point)))
              (member 'font-lock-type-face    (text-properties-at (point)))) ;; Added for things like 'SMALLINT'
	  (setq result (thing-at-point 'word))
	(forward-char)))
    result))

(defun cbl/sql/upcase-and-move-past-next-keyword ()
  "Upcase the next keyword and move point just past the keyword.  Return the keyword found, or nil."
  (let ((word (cbl/sql/move-to-next-keyword)))
    (when word
      (replace-string word (upcase word) nil (point) (+ (point) (length word)) ))
    word))

(defun cbl/sql/upper-case-keywords (begin end)
  "Upper-case SQL keywords in the region."
  (interactive "r")
  (save-excursion
    (goto-char begin)
    (while (and (cbl/sql/upcase-and-move-past-next-keyword)
		(< (point) end))
      :do-nothing)))

(provide 'cbl-sql)