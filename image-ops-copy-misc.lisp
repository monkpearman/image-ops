;;; :FILE-CREATED <Timestamp: #{2012-06-25T11:23:46-04:00Z}#{12261} - by MON>
;;; :FILE image-ops/image-ops-copy-misc.lisp
;;; ==============================

#|

 A regexp for matching pathname-name's having the form: 
  "018002-WEAR-08"
 
 (let ((inventory-pathname-name "018002-WEAR-08")) ; a fashion-inventory image without the pathname-type extensions
  (cl-ppcre:register-groups-bind (path number-string id-suffix numbered-suffix)
      ("((0[0-9]{5})-([A-Z]{4}(?-i)))-([0-9]{2})" inventory-pathname-name)
    (and path
         (list number-string id-suffix numbered-suffix path inventory-pathname-name))))
 => ("018002" "WEAR" "08" "018002-WEAR" "018002-WEAR-08")

|#

(in-package #:image-ops)


;; (copy-image-cmg-nefs :image-directory-pathname-source #P"<CMG-SOURCE-PATHNAME>"
;;                      :image-directory-pathname-base-target #P"<CMG-TARGET-PATHNAME>"
;;                      :image-match-regex (cl-ppcre:create-scanner "(cmg-\\d{4})(-\\d{1,2})"))
(defun copy-image-cmg-nefs (&key image-directory-pathname-source
                                 image-directory-pathname-base-target
                                 image-match-regex
                                 (delete-file-image-source t))
"Copy nef images matching IMAGE-MATCH-REGEX pattern
from IMAGE-DIRECTORY-PATHNAME-SOURCE to a corresponding subdir beneath
IMAGE-DIRECTORY-PATHNAME-BASE-TARGET (if it exists).
When DELETE-FILE-IMAGE-SOURCE is non-nil (the defalut) deletes each matched image
in source directory prior to returning.
IMAGE-MATCH-REGEX is a regular expression \(a string or cl-ppcre scanner\)
comprised of two register groups the first of which matches a file's image-name
with a target directory beneath IMAGE-DIRECTORY-PATHNAME-BASE-TARGET, the second
value is currently ignored but should _NOT_ contain a pattern matching the pathname-type.
:NOTE Currenly `directory-nef-images' is invoked with keyword :case-mode :down-case.
IOW, this function is hardwired to only matches pathnames where:
 \(equal \(pathname-type <MATCH>\) \"nef\"\)
:EXAMPLE
 \(copy-image-cmg-nefs :image-directory-pathname-source #P\"/mnt/foo/bar/baz/\"
                      :image-directory-pathname-base-target #P\"/mnt/quux/zomp/blarg/\"
                      :image-match-regex \(cl-ppcre:create-scanner \"\(cmg-\\\\d{4}\)\(-\\\\d{1,2}\)\"\)\)
:SEE-ALSO `copy-image-byte-file'.~%▶▶▶"
  (declare (pathname image-directory-pathname-source
                     image-directory-pathname-base-target))
  (let ((results nil)
        (delete-results nil))
    (setf results
          (loop
            for image-path in (directory-nef-images image-directory-pathname-source :case-mode :downcase)
            for image-name = (pathname-name image-path)
            when (let ((maybe-target-nef-directory nil))
                   (cl-ppcre:register-groups-bind (cmg cmg-suffix) (image-match-regex image-name)
                     (and cmg
                          cmg-suffix
                          (setf maybe-target-nef-directory
                                (nth-value 0
                                           ;; :NOTE repeatedly probing the same directory is likely a bottleneck
                                           (mon:probe-directory
                                            (merge-pathnames (make-pathname :directory (list :relative cmg))
                                                             image-directory-pathname-base-target))))
                          ;; (cons image-path
                          ;;                     (merge-pathnames (make-pathname :name image-name :type "nef")
                          ;;                                      maybe-target-nef-directory)))))
                          ;; collect it into gthr
                          ;; finally (return  gthr)))
                          (cons image-path
                                (copy-image-byte-file image-path
                                                      (merge-pathnames (make-pathname :name image-name :type "nef")
                                                                       maybe-target-nef-directory)
                                                      :set-dest-byte-file-write-date t)))))
            collect it into gthr))
    (if delete-file-image-source
        (unwind-protect
             (values results
                     (progn
                       (map nil #'(lambda (x) (or (and (delete-file (car x))
                                                       (push t delete-results))
                                                  (push (cons nil (car x)) delete-results)))
                            results)
                       delete-results))
          (values results delete-results))
        (values results delete-results))))

;;; ==============================


;; Local Variables:
;; indent-tabs-mode: nil
;; show-trailing-whitespace: t
;; mode: lisp-interaction
;; End:


;;; ==============================
;;; EOF
