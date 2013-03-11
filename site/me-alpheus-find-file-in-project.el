;;; me-alpheus-find-file-in-project.el --- A find-file-in-project that uses ido to select matching file names by regex (not file glob).
;;; 

;; Copyright (C) 2012  Craig B. Ludington

;; Author: Craig B. Ludington <me@alpheus.me>
;; Keywords: find-file-in-project ido convenience
;; Version: 0.0.1

;; This file is not part of Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; This program provides a function for finding a file in a project, using regexp rather
;;; than file glob.  The command you'll use is:
;;;
;;;    M-x me.alpheus/find-file-in-project
;;;
;;; You'll be prompted for a regex, and all the matching file names will be shown in the
;;; minibuffer (via ido-completing-read).  Select the file you want just as you would with
;;; ido-find-file.
;;;
;;; If there's only one match, that file is visited immediately in the current buffer.
;;;
;;; You define the project by customizing the variable:
;;;
;;;    me.alpheus/find-file-in-project-program
;;;
;;; which defaults to
;;;
;;;    "find ~ -type f -print"
;;;
;;; You'll probably want to replace "~" with the path to the root of your project.
;;; You may want to add some options to find for excluding files that you don't care about.
;;;
;;; The find command (or whatever you customize the variable me.alpheus/find-file-in-project-program to be)
;;; doesn't run every time.  How often it runs will be controlled by the customizable variable:
;;;
;;;    me.alpheus/find-file-in-project-program-staleness-threshold
;;;
;;; which defaults to 300.0 seconds.
;;;
;;; 
;;; Installation:
;;;
;;; To install, just drop this file into a directory in your
;;; `load-path' and (optionally) byte-compile it.  Then add:
;;;
;;;    (require 'me-alpheus-find-file-in-project)
;;;
;;; to your ~/.emacs (or ~/.emacs.d/init.el).
;;;
;;; Here's an example key binding:
;;;
;;;   (global-set-key (kbd "C-c C-f") 'me.alpheus/find-file-in-project)
;;;

(require 'cl)


;;; History:
;; 

;;; Code:
(defgroup me.alpheus/find-file-in-project nil
  "A find-file-in-project that uses ido to select files."
  :group 'extensions
  :group 'convenience)

(defcustom me.alpheus/find-file-in-project-program "find ~ -type f -print"
  "This program creates a list of file names for me.alpheus/find-file-in-project."
  :type 'string)

(defcustom me.alpheus/find-file-in-project-program-staleness-threshold 300.0
  "Number of seconds (as a float) before the file name list used by me.alpheus/find-file-in-project is considered stale."
  :type 'float)

(defcustom me.alpheus/find-file-in-project-scratch "*me.alpheus/find-file-in-project-scratch*"
  "Name of a scratch buffer to cache the file names in names of the files in the project."
  :type 'string)

(defvar *me.alpheus/find-file-in-project-last-run-time* nil)

(defun me.alpheus/find-file-in-project-reload ()
  "Force a refresh of the list of file names used by me.alpheus/find-file-in-project."
  (interactive)
  (setq *me.alpheus/find-file-in-project-last-run-time* nil))
  
(defun me.alpheus/find-file-in-project (regex)
  "Display a menu of file(s) matching REGEX (in the output of the program specified in me.alpheus/find-file-in-project-program)."
  (interactive "sFile regex: ")

  ;; Run "find" and cache the output
  (when (or (not *me.alpheus/find-file-in-project-last-run-time*)
            (> (- (float-time) *me.alpheus/find-file-in-project-last-run-time*)
               me.alpheus/find-file-in-project-program-staleness-threshold))
    (message (format "Running %s" me.alpheus/find-file-in-project-program))

    (save-excursion
      (with-current-buffer (get-buffer-create me.alpheus/find-file-in-project-scratch)
	(let ((undo-outer-limit nil))
	  (delete-region (point-min) (point-max)))
        (insert (shell-command-to-string me.alpheus/find-file-in-project-program))))
    (setq *me.alpheus/find-file-in-project-last-run-time* (float-time)))

  ;; Search the cached "find" output
  (flet ((occur (buf regexp)
                "Return a list of lines in buf matching regexp."
                (let ((matches '()))
                  (save-excursion
                    (with-current-buffer buf
                      (goto-char (point-min))
                      (let ((case-fold-search nil))
                        (while (re-search-forward regexp nil t)
                          (push (buffer-substring-no-properties (point-at-bol) (point-at-eol)) matches)))))
                  matches)))

    ;; Display a nice IDO menu of the matching file names.
    ;; File names are abbreviated for legibility (by removing the longest common prefix).
    ;; Don't break a filename in the middle of a path component.
    (let ((matches (occur me.alpheus/find-file-in-project-scratch regex)))
      (if matches
          (labels ((legible-filename (filename len)
                                     "Return the shortest legible substring prefix of filename that's no shorter than len (don't start in the middle of a path component)"
                                     (while (and (< 0 len)
                                                 (not (member (elt filename len) '(?/ ?\\ )))) ;; nod to DOS compatibility ;)
                                       (decf len))
                                     (substring filename len))
                   (abbreviate (lst)
                               "Return an assoc-list mapping the shortest possible unique file name to the full file name."
                               (let* ((common-prefix (reduce 'fill-common-string-prefix matches))
                                      (len           (if common-prefix (length common-prefix) 0))
                                      (abbreviations (if (< 0 len) (mapcar (lambda (filename) (legible-filename filename len)) matches) matches))
                                      (dictionary    (mapcar* 'cons abbreviations matches)))
                                 dictionary)))

            ;; If there's just one match, visit the file immediately.
            ;; Otherwise, show a menu of the abbreviated file names, then visit the selected file.
            (let ((file (if (= 1 (length matches))
                            (first matches)
                          (let* ((dictionary (abbreviate matches))
                                 (choice     (ido-completing-read "Matches: " (mapcar 'car dictionary))))
                            (cdr (assoc choice dictionary))))))
              (find-file file)))
	
        (message "No matches for %s" regex)))))

(defun me.alpheus/find-file-in-project-at-point ()
  "Interpret the sexp at point as a regexp and pass that to me.alpheus/find-file-in-project."
  (interactive)
  (let ((regexp (thing-at-point 'sexp)))
    (if (stringp regexp)
        (me.alpheus/find-file-in-project regexp)
      (message "Nothing here"))))

(provide 'me-alpheus-find-file-in-project)




(provide 'me-alpheus-find-file-in-project)

;;; me-alpheus-find-file-in-project.el ends here
