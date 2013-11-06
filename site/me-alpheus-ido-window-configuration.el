;;;; me-alpheus-ido-window-configuration.el
;;;;
;;;; Save/restore window configuration from registers with a nice ido-style menu of window configuration names.

(require 'ido)

(defvar *me.alpheus/window/register-map* 
  '()
  "Map window configuration names to the register they're stored in.  E.g. '((\"Work\" . 32768) (\"Play\" . 32769)")

(defun me.alpheus/window/restore (&optional name)
  "Restore a window configuration by name."
  (interactive)
  (let* ((name     (or name (ido-completing-read "Switch to: " (mapcar 'car *me.alpheus/window/register-map*))))
	 (register (cdr (assoc name *me.alpheus/window/register-map*)) ))
    (jump-to-register register)))

(defun me.alpheus/window/remove (&optional name)
  "Restore a window configuration by name."
  (interactive)
  (let ((name (or name (ido-completing-read "Remove: " (mapcar 'car *me.alpheus/window/register-map*)))))
    (setq *me.alpheus/window/register-map* (remove (assoc name *me.alpheus/window/register-map*) *me.alpheus/window/register-map*))))

(defun me.alpheus/window/save (&optional name)
  "Save a window configuration with a name."
  (interactive)
  (let ((name (or name (ido-completing-read  "Save window configuration as: " (mapcar 'car *me.alpheus/window/register-map*))))
	(register (loop for c from 32768 unless (get-register c) return c)))
    (flet ((save (name) 
		 (window-configuration-to-register register)
		 (add-to-list '*me.alpheus/window/register-map* (cons name register))))
      (if (assoc name *me.alpheus/window/register-map*)
	  (when (y-or-n-p (format "\"%s\" is in use.  Override?" name))
	    (me.alpheus/window/remove name)
	    (save name))
	(save name)))))

