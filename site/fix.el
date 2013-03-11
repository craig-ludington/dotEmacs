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