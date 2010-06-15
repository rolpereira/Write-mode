;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.




(defun write-help-fill-function ()
  (when (> (current-column) fill-column)
    (let (current-line (line-number-at-pos))
      (do-auto-fill)

      ;; Sometimes `do-auto-fill' doesn't change the line
      ;; (when (= current-line (line-number-at-pos))
      ;;   (newline))

      ;; When we are on a terminal, redisplaying the frame makes the
      ;; terminal flash. I don't like that.
      ;; (quote (4)) simulates a C-u M-x recenter
      (recenter (quote (4)))
      (indent-line-to 5)
      (move-end-of-line nil))))

(setq normal-auto-fill-function 'write-help-fill-function)
  
(setq mode-line-format nil)

(auto-fill-mode 1)

(local-set-key (kbd "RET") (lambda ()
                             (interactive)
                             (newline)
                             (recenter)
                             (indent-line-to 5)))
