;;; me-alpheus-remote-clipboard.el --- Copy/paste to a clipboard on a remote host (OS X only, probably).


;; Copyright (C) 2013 Craig B. Ludington 

;; Author: Craig B. Ludington <me@alpheus.me>
;; Keywords: osx clipboard ssh pbcopy pbpaste
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

;; This provides a function to copy the selection to the clipboard of a remote
;; host over SSH.  It only works on OS X, with the ``pbcopy'' and ``pbpaste'' commands,
;; (as far as I know).
;; If your OS has a command that can copy STDIN to the clipboard, Bob's your uncle.
;;
;; The hostname and the commands to copy/paste to the clipboard are customizable.
;;
;;; Installation:

;; To install, just drop this file into a directory in your
;; `load-path' and (optionally) byte-compile it.
;;
;; Add:
;;
;;    (require 'me-alpheus-remote-clipboard)
;;
;; to your ~/.emacs (or ~/.emacs.d/init.el).
;;
;; If you'd like to, add this too:
;;
;;    (global-set-key (kbd "C-c c") 'me.alpheus/remote-clipboard/copy)
;;    (global-set-key (kbd "C-c p") 'me.alpheus/remote-clipboard/paste)

;; Bugs:
;;    Copy doesn't handle quoting very well.
;;    Could be fixed by writing the clipboard contents to a temp file
;;    and having the pbcopy command read from that temp file.

(defgroup me.alpheus/remote-clipboard nil
  "Copy/paste to a clipboard on a remote host over secure shell."
  :group 'extensions
  :group 'convenience)

(defcustom me.alpheus/remote-clipboard/copy-cmd "pbcopy"
  "This command copies STDIN to the clipboard on a remote host for `me.alpheus/remote-clipboard/copy'."
  :type 'string)

(defcustom me.alpheus/remote-clipboard/paste-cmd "pbpaste"
  "This command pastes the clipboard to STDOUT on a remote host for `me.alpheus/remote-clipboard/paste'."
  :type 'string)

(defcustom me.alpheus/remote-clipboard/host "localhost"
  "This host owns the clipboard.  We copy to it and paste from it."
  :type 'string)

(defun me.alpheus/remote-clipboard/copy (begin end)
  (interactive "r")
  (let* ((content (buffer-substring-no-properties begin end))
	 (cmd (and content (format "echo '%s' | ssh %s '%s'"
			       content
			       me.alpheus/remote-clipboard/host
			       me.alpheus/remote-clipboard/copy-cmd
			       content)))
	 (result (and cmd (shell-command cmd)))
	 (msg (if result
		  (format "%s -- %s." cmd (if (zerop result)
					    "succeeded"
					   "failed"))
		"No active region to copy.")))
    (message msg)))

(defun me.alpheus/remote-clipboard/paste ()
  (interactive)
  (let ((cmd (format "ssh %s '%s'"
		     me.alpheus/remote-clipboard/host
		     me.alpheus/remote-clipboard/paste-cmd)))
    (shell-command (format "ssh %s '%s'"
			   me.alpheus/remote-clipboard/host
			   me.alpheus/remote-clipboard/paste-cmd)
		   t)))

(provide 'me-alpheus-remote-clipboard)
