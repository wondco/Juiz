#|
This file is a part of juiz project.
Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

#|
Author: Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage juiz-asd
  (:use :cl :asdf))
(in-package :juiz-asd)

(defsystem juiz
  :version "0.1"
  :author "Satoshi Iwasaki"
  :license "LLGPL"
  :depends-on (:alexandria
               :cl-ppcre
               :upanishad
               :shinrabanshou)
  :components ((:module "src"
                        :components
                        ((:file "package")
                         (:file "class"    :depends-on ("package"))
                         (:file "freewill" :depends-on ("class"))
                         (:file "juiz"     :depends-on ("freewill"))
                         )))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op juiz-test))))
