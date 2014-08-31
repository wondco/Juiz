(in-package :juiz)

(defclass freewill ()
  ((memory :documentation ""
           :accessor get-memory
           :initform nil
           :initarg  :memory)))


(defclass exit ()
  ((name :documentation ""
         :accessor get-name
         :initform nil
         :initarg  :name)))


(defclass concierge (exit freewill)
  ((mission-list :documentation ""
                 :accessor get-mission-list
                 :initform nil
                 :initarg  :mission-list)))


(defclass slecao (exit freewill) ())



(defclass mission ()
  ((concierge :documentation ""
              :accessor get-concierge
              :initform nil
              :initarg  :concierge)
   (slecao :documentation ""
           :accessor get-slecao
           :initform nil
           :initarg  :slecao)
   (contents :documentation ""
             :accessor get-contents
             :initform nil
             :initarg  :contents)
   (status :documentation ""
           :accessor get-status
           :initform :create
           :initarg  :status)
   (result :documentation ""
           :accessor get-result
           :initform nil
           :initarg  :result)
   (output :documentation ""
           :accessor get-output
           :initform nil
           :initarg  :output)
   (receipt-time :documentation ""
                 :accessor get-receipt-time
                 :initform nil
                 :initarg  :receipt-time)
   (thread :documentation ""
           :accessor get-thread
           :initform nil
           :initarg  :thread)
   (start-time :documentation ""
               :accessor get-start-time
               :initform nil
               :initarg  :start-time)
   (end-time :documentation ""
             :accessor get-end-time
             :initform nil
             :initarg  :end-time)))
