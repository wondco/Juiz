(in-package :juiz)

(defmethod say ((from freewill)
                (to freewill)
                message
                &key (time (get-universal-time)))
  (push (list :time time :type :out :message message)
        (get-memory from))
  (push (list :time time :type :in :message message)
        (get-memory to)))

