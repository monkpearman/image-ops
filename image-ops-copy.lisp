;;; :FILE-CREATED <Timestamp: #{2012-05-30T20:31:08-04:00Z}#{12223} - by MON>
;;; :FILE image-ops/image-ops-copy.lisp
;;; ==============================

(in-package #:image-ops)

;; adapted from `copy-byte-stream' in clime/copy-bytes.lisp
(defun copy-image-byte-stream (from-byte-stream to-byte-stream &key (element-type 'unsigned-byte))
  (let ((byte-stream-bfr (make-array 4096 :element-type element-type)))
    (do ((byte-stream-pos (read-sequence byte-stream-bfr from-byte-stream)
                          (read-sequence byte-stream-bfr from-byte-stream)))
        ((zerop byte-stream-pos) nil)
      (write-sequence byte-stream-bfr to-byte-stream :end byte-stream-pos))))

;; adapted from `copy-byte-file' in clime/copy-bytes.lisp
(defun copy-image-byte-file (source-byte-file dest-byte-file
                             &key (if-exists :supersede) ;; :error
                                  (element-type    'unsigned-byte)
                                  (set-dest-byte-file-write-date nil))
  ;; (external-format :default)
  ;; (report-stream   *standard-output*))
  ;; (verify-element-type-for-copy-byte element-type :stream report-stream)
  (with-open-file (byte-input source-byte-file
                              :direction         :input
                              :if-does-not-exist :error
                              ;; :external-format   external-format ; Is this ever applicable?
                              :element-type      element-type)
    (with-open-file (byte-output dest-byte-file
                                 :direction         :output
                                 :if-does-not-exist :create
                                 :if-exists         if-exists
                                 ;; :external-format   external-format ; Is this ever applicable?
                                 :element-type      element-type)
      (copy-image-byte-stream byte-input
                              byte-output
                              :element-type element-type)))
  (and
   ;; We probe-file here to ensure that the copy actually occured b/c it may
   ;; have errored. In particular it may have done so around an :if-exists when
   ;;  (eql if-exists :error)
   (probe-file dest-byte-file)
   (and set-dest-byte-file-write-date
        (or (mon::set-file-write-date-using-file  (namestring dest-byte-file) (namestring source-byte-file))
            t))
   dest-byte-file))

;;; ==============================


;; Local Variables:
;; indent-tabs-mode: nil
;; show-trailing-whitespace: t
;; mode: lisp-interaction
;; End:

;;; ==============================
;;; EOF
