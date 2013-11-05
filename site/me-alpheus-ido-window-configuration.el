;;;; me-alpheus-ido-window-configuration.el
;;;;
;;;; Save/restore window configuration from registers with a nice ido-style menu of window configuration names.

(require 'ido)

(defvar *me.alpheus/window/register-map*
  '()
  "Map window configuration names to the register they're stored in.  E.g. '((\"Work\" . ?) (\"Play\" . ?p)")

(defun me.alpheus/window/register-of (name)
  (cdr (assoc name *me.alpheus/window/register-map*)))

(defun me.alpheus/window/add-mapping (name register)
  (add-to-list '*me.alpheus/window/register-map* (cons name register)))

(defun me.alpheus/window/save (register)
  (interactive "cWindow configuration register? ")
  (if (and (get-register register)
	   (not (y-or-n-p (format "Register '%c' is in use.  Override?" register))))
      (message "Skipping")
    (let ((name (read-from-minibuffer "Window configuration name? ")))
      (if (and (me.alpheus/window/register-of name)
	       (not (y-or-n-p (format "\"%s\" is in use.  Override?" name))))
	  (message "Skipping")
	(progn (window-configuration-to-register register)
	       (me.alpheus/window/add-mapping name register))))))

(defun me.alpheus/window/restore ()
  "Prompt for a window configuration to restore, the IDO way."
  (interactive)
  (jump-to-register (me.alpheus/window/register-of 
		     (ido-completing-read "Window configuration: "
					  (mapcar 'car *me.alpheus/window/register-map*)))))


;;; window-configuration-p
;;; register-alist
