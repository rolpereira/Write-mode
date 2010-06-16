
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

  (define-key write-mode-map (kbd "RET") 'write-mode-newline-recenter-indent)

  ;; Place cursor at the line in the middle of the screen
  (let ((middle-line (/ (window-height (get-buffer-window)) 2)))
    ;; If there are already characters typed, we assume we are loading
    ;; from a saved file, and simply go to the end of the buffer and
    ;; recenter it.
    (if (not (string=
               (buffer-substring-no-properties (point-min) (point-max)) ""))
      (progn
        (goto-char (- (point-max) 1))
        (recenter))
      (goto-char (point-min)) ; Although we should be there already
      (newline middle-line)
      (indent-line-to write-mode-left-margin))))
