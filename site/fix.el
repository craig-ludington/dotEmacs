;;;; FIX.el
;;;; Contains nothing but fixes for packages I've loaded from elsewhere.
;;;; Any time a package is updated, this file must be checked.


;;; package.el --- Simple package system for Emacs

;; Copyright (C) 2007-2011 Free Software Foundation, Inc.

;; Author: Tom Tromey <tromey@redhat.com>
;; Created: 10 Mar 2007
;; Version: 0.9
;; Keywords: tools
(defun package-delete (name version)
  (let ((dir (package--dir name version)))
    (if (string-equal (file-name-directory dir)
		      (file-name-as-directory
		       (expand-file-name package-user-dir)))
	(progn
	  ;; (delete-directory dir t t)
	  (delete-directory dir)
	  (message "Package `%s-%s' deleted." name version))
      ;; Don't delete "system" packages
      (error "Package `%s-%s' is a system package, not deleting"
	     name version))))


;;; midnight.el --- run something every midnight, e.g., kill old buffers
(defun clean-buffer-list ()
  "Kill old buffers that have not been displayed recently.
The relevant variables are `clean-buffer-list-delay-general',
`clean-buffer-list-delay-special', `clean-buffer-list-kill-buffer-names',
`clean-buffer-list-kill-never-buffer-names',
`clean-buffer-list-kill-regexps' and
`clean-buffer-list-kill-never-regexps'.
While processing buffers, this procedure displays messages containing
the current date/time, buffer name, how many seconds ago it was
displayed (can be nil if the buffer was never displayed) and its
lifetime, i.e., its \"age\" when it will be purged."
  (interactive)
  (let ((tm (float-time)) bts (ts (format-time-string "%Y-%m-%d %T"))
        delay cbld bn)
    (dolist (buf (buffer-list))
      (when (buffer-live-p buf)
	(setq bts (midnight-buffer-display-time buf) bn (buffer-name buf)
	      delay (if bts (- tm bts) 0) cbld (clean-buffer-list-delay bn))
	;; (message "[%s] `%s' [%s %d]" ts bn (if bts (round delay)) cbld)  ;;;; TOO DAMN NOISY
	(unless (or (midnight-find bn clean-buffer-list-kill-never-regexps
				   'string-match)
		    (midnight-find bn clean-buffer-list-kill-never-buffer-names
				   'string-equal)
		    (get-buffer-process buf)
		    (and (buffer-file-name buf) (buffer-modified-p buf))
		    (get-buffer-window buf 'visible) (< delay cbld))
	  (message "[%s] killing `%s'" ts bn)
	  (kill-buffer buf))))))
