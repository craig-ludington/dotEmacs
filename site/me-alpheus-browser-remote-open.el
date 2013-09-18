
;;; me-alpheus-browser-remote-open.el --- Display the URI at point on a different host using SSH.

;; Copyright (C) 2013 Craig B. Ludington 

;; Author: Craig B. Ludington <me@alpheus.me>
;; Keywords: browser ssh
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

;; This provides a function to display the URI at point on a remote host accessible by SSH.
;; The hostname and the command to open a URI are customizable.
;;
;;; Installation:

;; To install, just drop this file into a directory in your
;; `load-path' and (optionally) byte-compile it.
;;
;; Add:
;;
;;    (require 'me-alpheus-browser-remote-open)
;;
;; to your ~/.emacs (or ~/.emacs.d/init.el).
;;
;; If you'd like to, add this too:
;;
;;    (global-set-key (kbd "C-c r") 'me.alpheus/browser/remote-open)

(defgroup me.alpheus/browser/remote-open nil
  "Open a URI for browsing on a remote host."
  :group 'extensions
  :group 'convenience)

(defcustom me.alpheus/browser/remote-open-command "open"
  "This command opens a url on a remote host for `me.alpheus/browser/remote-open'"
  :type 'string)

(defcustom me.alpheus/browser/remote-host "localhost"
  "This host displays a URI for `me.alpheus/browser/remote-open'."
  :type 'string)

(defun me.alpheus/browser/private/remote-open (url)
  (shell-command (format "ssh %s '%s %s'" 
                         me.alpheus/browser/remote-host
                         me.alpheus/browser/remote-open-command
                         url)))

(defun me.alpheus/browser/remote-open ()
  (interactive)
  (me.alpheus/browser/private/remote-open (thing-at-point 'url)))

(defun me.alpheus/browser/find-file-at-point (url &optional ignored)
  (interactive)
  (me.alpheus/browser/private/remote-open url))

(provide 'me-alpheus-browser-remote-open)

