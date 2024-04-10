;;; -*- mode: lisp -*-
;;; :FILE image-ops/image-ops.asd
;;; ==============================

;; ,----
;; | "I am sick to death of knee-jerk anti-LOOPism and I am beginning to
;; |  irrationally regard it as a plot to disable me as a programmer by
;; |  excommunicating my useful tools."
;; |
;; |     :SOURCE "Knee-jerk Anti-LOOPism and other E-mail Phenomena" p 17
;; `---- :SEE http://ccs.mit.edu/papers/CCSWP150.html



(defpackage #:image-ops-build-system (:use :common-lisp :asdf))

(in-package #:image-ops-build-system)

(defvar *author-maintainer-contact* (format nil "MON KEY -- ~A"
                                 (map 'string
                                      'code-char
                                      #(109 111 110 107 101 121 64 115 97 110 100 112 
                                        102 114 97 109 105 110 103 46 99 111 109))))

(defsystem :image-ops
  ;; :name ""
  :author  "MON KEY"
  :maintainer #.*author-maintainer-contact*
  :license "MIT"
  :description "image operations agglomerated"
  :version "1.0.0"
  :depends-on (:mon
               :local-time
               :tiff4cl
               ;; :zpng
               ;; :png-read
               ;; :image-ops-jpeg
               )
  :serial t
  :components
  ((:file "package")
   (:file "image-ops-specials")
   (:file "image-ops-macros")
   ;; (:file "image-ops-png") ; requires zpng and png-read
   (:file "image-ops-copy")
   (:file "image-ops-rotate")
   (:file "image-ops-hash-dir-tree")
   (:file "image-ops-iphone")
   (:file "image-ops-nikon-nef")
   (:file "image-ops-copy-misc")
   (:file "image-ops-docs")
   #+IS-MON (:file "image-ops-loadtime-bind")
   ))

;;; ==============================


;; Local Variables:
;; indent-tabs-mode: nil
;; show-trailing-whitespace: t


;;; ==============================
;;; EOF

