#!/bin/sh
#
#
###  ==============================
# :FILE-CREATED <Timestamp: #{2024-08-22T14:00:22-04:00Z}#{24344} - by MON>
# :FILE image-ops/make-image-ops-etags.sh
#
# quickly find all the lisp files here:
# shell> find . -name "*.lisp" -print
# (call-process-shell-command (concat "find -f " default-directory  "*.lisp") nil t)
#
#  Add the current directory to the tail of Emacs' `tags-table-list'
#  and make sure to tell customize or it'll wind up bitching:
# (progn (add-to-list 'tags-table-list default-directory t) (custom-note-var-changed 'tags-table-list))
# 
#
# I've always wondered why authors of CL DSLs often name write their macros
# def-<FOO> (as opposed to some less lispy prefix or no prefix at all). 
# TIL that apparently etags --language=lisp finds pretty much anything "def-" or
# "(pkg:def*" at BOL. This Includes stuff like "(sb-rt:deftest".
#
###  ==============================

etags ./image-ops-copy-misc.lisp \
./image-ops-copy.lisp \
./image-ops-docs.lisp \
./image-ops-hash-dir-tree.lisp \
./image-ops-iphone.lisp \
./image-ops-loadtime-bind.lisp \
./image-ops-macros.lisp \
./image-ops-nikon-nef.lisp \
./image-ops-png.lisp \
./image-ops-rotate.lisp \
./image-ops-specials.lisp \
--language=lisp

###  ==============================
### EOF
