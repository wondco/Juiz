#|
  This file is a part of juiz project.
  Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage juiz-test-asd
  (:use :cl :asdf))
(in-package :juiz-test-asd)

(defsystem juiz-test
  :author "Satoshi Iwasaki"
  :license "LLGPL"
  :depends-on (:juiz
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "juiz"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
