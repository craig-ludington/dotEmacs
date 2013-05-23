;; Create a chat group
;; /msg &bitlbee join_chat 0 junky@conference.cashnetusa.com #junky
;; /invite esambo #junky
;; 

(defun cbl/erc/bitlbee-privmsg (target message)
  "Send a privmsg to the current channel's default target."
  (let ((msg (format "%s %s" target message)))
    (message "PRIVMSG %s " msg)
    (erc-message "PRIVMSG" msg)))

(defmacro cbl/erc/with-bitlbee-buffer (&rest body)
  "Execute BODY in the &bitlbee buffer.  If no &bitlbee buffer exists, return nil."
  (let ((buffer (make-symbol "buffer")))
    `(let ((,buffer (get-buffer "&bitlbee")))
       (when (buffer-live-p ,buffer)
	 (with-current-buffer ,buffer
	   ,@body)))))
(put 'cbl/erc/with-bitlbee-buffer 'lisp-indent-function 0)
(put 'cbl/erc/with-bitlbee-buffer 'edebug-form-spec '(body))

(defun cbl/erc/join-bitlbee-channel (channel)
  "Join a bitlbee channel."
  ;; (interactive "sChannel:")
  (cbl/erc/with-bitlbee-buffer
    (cbl/erc/bitlbee-privmsg (erc-default-target) (format "join_chat 0 %s@conference.cashnetusa.com #%s" channel channel))))

(defun cbl/erc/join-bitlbee-channels ()
  (interactive)
  (dolist (channel '("dev" "db" "trolls"))
      (cbl/erc/join-bitlbee-channel channel)))

(defun cbl/erc/format-buffer-major-mode ()
  "Format the major mode as it appears in *Buffers*, e.g. \"ERC: CLOSED\"."
  (let ((buffer (current-buffer)))
    (concat (format-mode-line mode-name nil nil buffer)
	    (if mode-line-process
		(format-mode-line mode-line-process
				  nil nil buffer)))))

(defun cbl/erc/kill-closed-erc-buffers ()
  (interactive)
  (dolist (buffer (erc-buffer-list))
    (when (string-equal ": CLOSED" (format-mode-line mode-line-process nil nil buffer))
      (kill-buffer buffer))))
			
(defun cbl/erc/kill-buffer-query-function ()
  "Ask before killing an ERC buffer."
  (if (and (eql 'erc-mode major-mode)
	   (erc-server-process-alive))
      (yes-or-no-p (format "Buffer `%s' is an ERC buffer; kill it? "
			   (buffer-name (current-buffer))))
    t))

(add-hook 'kill-buffer-query-functions 'cbl/erc/kill-buffer-query-function)


;; (defun cbl/erc/reformat-jabber-backlog ()
;;   "Fix \"unkown participant\" backlog messages from bitlbee."
;;   (save-excursion
;;     (goto-char (point-min))
;;     (if (looking-at
;;     	 "^<root> System message: Message from unknown participant \\([^:]+\\):")
;;     	(replace-match "<\\1>"))))
;; (add-hook 'erc-insert-modify-hook 'cbl/erc/reformat-jabber-backlog)
