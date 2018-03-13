;;;; Emacs Lisp helpers for dealing with PSM requirements.

(defvar psm-reqs
  "An alist of PSM requirements.  Each element maps a symbol to a string:

    '((id \"psm-FR-5.2\")
      (category \"FR 5. Manage Enrollment\")
      (description \"The PSM shall allow providers to terminate their ...\")
      (comment \"PSM should capture a termination reason code. ...\"))
  
  Use `psm-load-reqs' to initialize this."
  nil)

(defun psm-load-reqs (file)
  "Load PSM requirements from a FILE generated with 'show-reqs elisp'.
E.g., run './show-reqs elisp > reqs.eld' at a shell prompt, and then
run `M-x psm-load-reqs' in Emacs and give the path to 'reqs.eld' when
prompted for a file name."
  (interactive "fLoad PSM requirements from file: ")
  (save-excursion
    (let* ((large-file-warning-threshold nil)
           (buf (find-file-noselect file)))
      (set-buffer buf)
      (goto-char (point-min))
      (setq psm-reqs (read (current-buffer)))
      (kill-buffer (current-buffer)))))

(defun psm-show-req (&optional verbose)
  "Show information of the requirement point is currently in.
For example, if point is in the string \"psm-FR-5.2\",
then display (using as little screen space as possible)
the requirement's name, category, description, and any comment.

If prefix argument VERBOSE is non-nil, show all details about
the requirement (e.g., source, release, etc)."
  (interactive "P")
  (let* ((req-name (let ((raw (thing-at-point 'filename t)))
                     (when (>= (length raw) 8)
                       ;; If we have "psm-fr-5.2", convert
                       ;; it to "psm-FR-5.2".
                       (aset raw 4 (upcase (aref raw 4)))
                       (aset raw 5 (upcase (aref raw 5))))
                     raw))
         (req      (cl-some (lambda (candidate)
                              (when (string-equal 
                                     req-name (cadr (assq 'id candidate)))
                                candidate))
                            psm-reqs))
         (req-id                   (cadr (assq 'id req)))
         (req-description          (cadr (assq 'description req)))
         (req-category             (cadr (assq 'category req)))
         (req-comment              (cadr (assq 'comment req)))
         (req-priority             (cadr (assq 'priority req)))
         (req-rank                 (cadr (assq 'rank req)))
         (req-source               (cadr (assq 'source req)))
         (req-source-doc           (cadr (assq 'source-doc req)))
         (req-release              (cadr (assq 'release req)))
         (req-design-ref           (cadr (assq 'design-ref req)))
         (req-acceptance-test-ref  (cadr (assq 'acceptance-test-ref req)))
         (buf              (get-buffer-create "*PSM req*")))
    (save-excursion
      (set-buffer buf)
      (delete-region (point-min) (point-max))
      (put-text-property 0 (length req-id) 'face
                         '(:weight bold :underline t)
                         req-id)
      (insert (format "%s" req-id))
      (insert (format "         (%s)\n\n" req-category))
      (insert (format "%s\n\n" req-description))
      (forward-char -2)
      (let ((fill-prefix nil))
        (fill-paragraph))
      (goto-char (point-max))
      ;; Comments are especially likely to be multi-line,
      ;; so handle them specially.
      (when (and req-comment (not (string-equal req-comment "")))
        (insert (if verbose "Comment: " "COMMENT: ")
                (format "%s\n\n" req-comment))
        (forward-char -2)
        (let ((fill-prefix "         "))
          (fill-paragraph))
        (goto-char (point-max)))
      (when verbose
        ;; Expect any other optional fields to be one line.
        (dolist (field '(req-priority req-rank req-source req-source-doc
                                      req-release req-design-ref 
                                      req-acceptance-test-ref))
          (let ((val (symbol-value field))
                (label (capitalize (substring (symbol-name field) 4))))
            (when val
              (insert label ": ")
              (insert val "\n\n")))))
      ;; Because display-buffer ignores trailing blank lines when
      ;; calculating the optimum window size, we insert an invisible
      ;; character at the end to force the spacing to be such that the
      ;; description (and comment, if any) are vertically centered.
      (insert ".")
      (put-text-property (- (point) 1) (point) 'invisible t)
      ;; Put point at the top, lest the displayed window default to
      ;; the wrong part of the text.
      (goto-char (point-min)) (end-of-line)
      (display-buffer buf
                      '(display-buffer-at-bottom 
                        . ((window-height 
                            . shrink-window-if-larger-than-buffer)))))))
