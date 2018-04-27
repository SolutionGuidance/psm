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

(defun psm-get-req (req-name)
  "Return the req object for req identifier REQ-NAME, else nil.
REQ-NAME can be in non-canonical case."
  (let ((req-name (psm-req-case-canonicalize-name req-name)))
    (cl-some (lambda (candidate)
               (when (string-equal
                      req-name (cadr (assq 'id candidate)))
                 candidate))
             psm-reqs)))

(defun psm-req-case-canonicalize-name (req-name)
  "Return a canonicalized version of REQ-NAME.
Canonicalized means ensuring that the \"psm-\" prefix
is on the front and is lower-case, and that the
two-letter subcode is upper case.  For example, this
would convert \"PSM-fr-5.2\" to \"psm-FR-5.2\", and
would convert \"fr-5.2\" to \"psm-FR-5.2\"."
  (let ((new-req-name (copy-sequence req-name)))
    (save-match-data
      ;; I wish Elisp had `starts-with'.  There's
      ;; `bash-completion-starts-with', in the emacs-bash-completion
      ;; project, and its implementation is very simple:
      ;;
      ;;   (defun bash-completion-starts-with (str prefix)
      ;;     "Return t if STR starts with PREFIX."
      ;;     (let ((prefix-len (length prefix))
      ;;   	(str-len (length str)))
      ;;       (and
      ;;        (>= str-len prefix-len)
      ;;        (string= (substring str 0 prefix-len) prefix))))
      ;;
      ;; But this is not the place, and now is not the time.
      (when (not (string-match "^psm-" new-req-name))
        (setq new-req-name (concat "psm-" new-req-name))))
    (aset new-req-name 0 (downcase (aref new-req-name 0)))
    (aset new-req-name 1 (downcase (aref new-req-name 1)))
    (aset new-req-name 2 (downcase (aref new-req-name 2)))
    (aset new-req-name 4 (upcase (aref new-req-name 4)))
    (aset new-req-name 5 (upcase (aref new-req-name 5)))
    new-req-name))

(defun psm-req-name-at-point ()
  "Return the req name at point, canonicalized.
The req name may have the \"psm-\" prefix but does not require it."
  (let* ((raw (thing-at-point 'filename t))
         (len (length raw)))
    (when (< len 6)
      (error "'%s' is too short to be a PSM req ID" raw))
    (let ((case-fold-search t))
      (save-match-data
        (if (string-match "\\(psm-\\)?[A-Z][A-Z]-[0-9]+\\.[0-9]+" raw)
            ;; The regexp above doesn't begin with "^" nor
            ;; end with "$" because `thing-at-point' may
            ;; include leading or trailing garbage.  E.g., in
            ;; "psm-FR-1.1, psm-FR-1.2, psm-FR-1.3", calling
            ;; with point on either of the first two would
            ;; include the trailing comma.  Here we strip
            ;; off stuff that isn't part of the ID.
            (setq raw (match-string 0 raw))
          (error "'%s' doesn't look like a PSM req ID" raw))))
    (psm-req-case-canonicalize-name raw)))

;; Went back and forth on using `cl-defstruct' for this.
(defmacro psm-req-get (req field)
  `(cadr (assq ,field ,req)))

(defun psm-insert-req-summary (req-name)
  "Insert a summary of REQ-NAME, preserving fill from bol to point."
  (let* ((req  (psm-get-req req-name))
         (desc (psm-req-get req 'description))
         (cat  (psm-req-get req 'category))
         (prefix (buffer-substring
                  (point) (save-excursion (beginning-of-line) (point)))))
      (insert desc "\n")
      (let ((opoint (point-marker)))
        (forward-line -1)
        (fill-paragraph)
        (goto-char opoint))
      (insert prefix "<<< " cat " >>>\n")))

(defun psm-show-req (&optional verbose)
  "Show information of the requirement point is currently in.
For example, if point is in the string \"psm-FR-5.2\",
then display (using as little screen space as possible)
the requirement's name, category, description, and any comment.

If prefix argument VERBOSE is non-nil, show all details about
the requirement (e.g., source, release, etc)."
  (interactive "P")
  (let* ((req-name                 (psm-req-name-at-point))
         (req                      (psm-get-req req-name))
         (req-id                   (psm-req-get req 'id))
         (req-description          (psm-req-get req 'description))
         (req-category             (psm-req-get req 'category))
         (req-comment              (psm-req-get req 'comment))
         (req-priority             (psm-req-get req 'priority))
         (req-rank                 (psm-req-get req 'rank))
         (req-source               (psm-req-get req 'source))
         (req-source-doc           (psm-req-get req 'source-doc))
         (req-release              (psm-req-get req 'release))
         (req-design-ref           (psm-req-get req 'design-ref))
         (req-acceptance-test-ref  (psm-req-get req 'acceptance-test-ref))
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
                            . fit-window-to-buffer)))))))
