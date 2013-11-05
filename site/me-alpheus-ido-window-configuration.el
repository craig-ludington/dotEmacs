;;;; me-alpheus-ido-window-configuration.el
;;;;
;;;; Save/restore window configuration from registers with a nice ido-style menu of window configuration names.

(require 'ido)

(defvar *me.alpheus/window/register-map* 
  '()
  "Map window configuration names to the register they're stored in.  E.g. '((\"Work\" . 32768) (\"Play\" . 32769)")

(defun me.alpheus/window/save (name)
  (interactive "MSave window configuration as: ")
  (let ((register (loop for c from 32768 unless (get-register c) return c)))
    (flet ((save (name) 
		 (window-configuration-to-register register)
		 (add-to-list '*me.alpheus/window/register-map* (cons name register))))
      (if (assoc name *me.alpheus/window/register-map*)
	  (when (y-or-n-p (format "\"%s\" is in use.  Override?" name))
	    (save name))
	(save name)))))

(defun me.alpheus/window/restore ()
  "Prompt for a window configuration to restore."
  (interactive)
  (let* ((name     (ido-completing-read "Switch to: " (mapcar 'car *me.alpheus/window/register-map*)))
	 (register (cdr (assoc name *me.alpheus/window/register-map*)) ))
    (jump-to-register register)))

(defun me.alpheus/window/remove ()
  "Prompt for a window configuration to remove."
  (interactive)
  (let ((name (ido-completing-read "Remove: " (mapcar 'car *me.alpheus/window/register-map*))))
    (setq *me.alpheus/window/register-map*
	  (remove (assoc name *me.alpheus/window/register-map*) *me.alpheus/window/register-map*))))
