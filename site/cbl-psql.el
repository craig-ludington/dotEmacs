;; cbl-psql - Use ~/.pgpass to connect to databases using the psql program.


(defun cbl/psql/get-tunnel-command ()
  (let ((s (cbl/get-previous-line)))
    (and s
	 (string-match-p "^# ssh " s)
	 (substring s 2))))

(defun cbl/psql-from-spec (spec)
  "Log in to postgres db using a spec from ~/.pgpass
   Sample spec:
     slavedb.cashnetusa.com:5432:cnuapp_prod:cludington:SeKrIt 
   Sets sql-buffer for sql-send-region to use."
  (multiple-value-bind (host port db user _) (split-string spec ":")
    (let ((buf (make-comint (format "PSQL %s@%s" db host) "/usr/local/bin/psql" nil "-U" user "-h" host "-p" port "--pset" "pager=off" db)))
      ;; sql-buffer is defined in sql.el -- shadowed by buffer-local variables in sql-mode
      (setq sql-buffer buf) 
      (switch-to-buffer buf))))

(defun cbl/psql ()
  "If the current line looks like an entry in ~/.pgpass, open it in psql.
If the current line is preceeded by an SSH command, execute that first (to set up a port forward)."
  (interactive)
  (if (string= (buffer-name) ".pgpass")
      (let ((c (cbl/psql/get-tunnel-command)))
	(when c
	  (let* ((buf-name (concatenate 'string "*" c "*"))
		 (buf      (get-buffer-create buf-name))
		 (proc     (get-buffer-process buf))
		 (running? (and proc (eq (process-status proc) 'run))))
	    (if running?
		(message "%s has a running process" buf-name)
	      (progn
		(message "Starting %s" c)
		(shell-command c buf)
		(sleep-for 3)))))
	(cbl/psql-from-spec (cbl/get-current-line)))
    (find-file "~/.pgpass")))

;; (global-set-key (kbd "s-p") 'cbl/psql)


(defun cbl/psql-command-from-spec (spec sql-command)
  "Log in to postgres db using a spec from ~/.pgpass and execute sql-command.
   Return the whole buffer as a string.
   Sample spec:
     slavedb.cashnetusa.com:5432:cnuapp_prod:cludington:SeKrIt 
   Sets sql-buffer for sql-send-region to use."
  (multiple-value-bind (host port db user _) (split-string spec ":")
    (let ((buf (make-comint (format "PSQL %s@%s" db host) "/usr/local/bin/psql" nil "-U" user "-h" host "-p" port "--pset" "pager=off" db)))
      (with-current-buffer buf
	(comint-send-input "\\t")
	(comint-send-input "\\a")
	(comint-send-input sql)
	))))

(provide 'cbl-psql)

;; Options available through the \pset command:
;;
;; |----------------------+-------------+------------------------------|
;; | Format               | Parameter   | Options                      |
;; |----------------------+-------------+------------------------------|
;; | Field alignment      | format      | unaligned aligned html latex |
;; | Field separator      | fieldsep    | separator                    |
;; | One field per line   | expanded    |                              |
;; | Rows only            | tuples_only |                              |
;; | Row separator        | recordsep   | separator                    |
;; | Table title          | title       | tibtle                       |
;; | Table border         | border      | 0 1 2                        |
;; | Display NULL  values | null        | null_string                  |
;; | HTML table tags      | tableattr   | tags                         |
;; | Page output          | pager       | command                      |
;; |----------------------+-------------+------------------------------|

