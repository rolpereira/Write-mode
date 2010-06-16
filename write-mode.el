
(defvar write-mode-left-margin 5
  "The number of spaces on the left margin of every line.")

(defun write-mode-fill-function ()
  (when (> (current-column) fill-column)
    (let (current-line (line-number-at-pos))
      (do-auto-fill)
      ;; When we are on a terminal, redisplaying the frame makes the
      ;; terminal flash. I don't like that.
      ;; (quote (4)) simulates a C-u M-x recenter
      (recenter (quote (4)))
      (indent-line-to write-mode-left-margin)
      (move-end-of-line nil))))

(defun write-mode-newline-recenter-indent ()
  "Inserts a newline on the buffer, recenters the screen and indents
the line that was just created with `write-mode-left-margin' spaces"
  (interactive)
  (newline)
  (recenter)
  (indent-line-to write-mode-left-margin))

(define-derived-mode write-mode text-mode "Write"
  "Mode that helps you write text without any distractions."
  (setq normal-auto-fill-function 'write-mode-fill-function)
  (setq mode-line-format nil) ; Remove the mode-line (only for this buffer)
  (auto-fill-mode 1)

  (define-key write-mode-map (kbd "RET") (lambda ()
                                           (interactive)
                                           (newline)
                                           (recenter)
                                           (indent-line-to 5))))
  
