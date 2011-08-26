;;-*- Mode: LISP; Syntax: COMMON-LISP; Encoding: utf-8; Base: 10; -*-
;;; :FILE image-ops/package.lisp
;;; ==============================

;; (in-package #:image-ops) ;; for Slime
;; *package*


(defpackage #:image-ops (:use #:common-lisp) ;; #+sbcl #:sb-int
            (:export 
             ;;
           ;; image-ops-docs.lisp
             ;;
             #:*PSD-SCANNER* 
             #:*JPG-GZ-SCANNER* 
             #:*JPG-SCANNER* 
             #:*BMP-SCANNER* 
             #:*BMP-GZ-SCANNER* 
             #:*NEF-SCANNER* 
             #:*TIFF-SCANNER*
             #:*EXTENSION-GZ-SCANNER*
             ;;
             #:*BMP-HASH*  
             #:*BMP-GZ-HASH*
             #:*NEF-HASH*  
             #:*JPG-HASH* 
             #:*JPG-GZ-SCANNER* 
             #:*TIFF-HASH*  
             #:*PSD-HASH*   
             #:*OTHER-HASH*
             ;;
             ;; 
          ;; image-hash-directory-tree.lisp
             ;;
             ;; #:%absolute-existent-file-or-directory
             ;; #:%ensure-simple-namestring
             ;; #:%walk-directory-filter-ignorables
             ;; #:%partition-walked-files
             #:image-hash-reset-all
             #:image-hash-counts-report
             #:walk-directory-images-to-hash
             ;;
           ;; image-ops-rotate.lisp
             #:verify-image-magic-convert-path
             #:verify-image-file-output-type
             #:verify-image-file-file-kind
             #:unset-special-param-read-image-file-list
             #:read-image-file-list-from-file
             #:read-image-file-list-from-fprint0-file
             #:make-target-pathname-for-image-resize
             #:make-pathname-source-destination-resize-pairs
             #:write-fprint0-file-for-image-files-in-pathname
             #:resize-image-files-in-fprint0-file
             #:rotate-image-files-in-dir-list

           ;; image-ops-docs.lisp

             ))


;;; ==============================


;; Local Variables:
;; indent-tabs-mode: nil
;; show-trailing-whitespace: t
;; mode: lisp-interaction
;; End:

;;; ==============================
;;; EOF
