;; cnuapp-customization.el
;;
;; Don't put anything here that you won't need at another job!

(defun script-console-integration ()
  (interactive)
  (run-ruby "~/bin/script-console-integration"))

(defun script-console (args)
  (interactive "MExtra args: ")
  (run-ruby (format "~/bin/script-console %s" (or args ""))))