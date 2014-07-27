(in-package :juiz)

(defun default-thread-name ()
  (multiple-value-bind (second minute hour date month year day daylight-p zone)
      (decode-universal-time (get-universal-time))
    (declare (ignore day daylight-p))
    (format nil "From juiz. ~a-~a-~a ~a:~a:~a (~a) enterd"
            year month date
            hour minute second
            zone)))

(defun enter-thread (func &optional (name (default-thread-name)))
  #+sbcl (sb-thread:make-thread  func :name name)
  #+ccl  (ccl:process-run-function name func))

(defmethod make-mission ((slecao slecao) (juiz juiz) contents)
  (make-instance 'mission :slecao slecao
                 :juiz juiz
                 :contents contents
                 :receipt-time (get-universal-time)))

(defmacro request (slecao juiz &body body)
  `(let ((mission (make-mission ,slecao
                                ,juiz
                                (lambda () ,@body))))
     (push mission (get-mission-list ,juiz))
     mission))

(defmethod operation (mission)
  (lambda ()
    (setf (get-status mission) :start)
    (setf (get-start-time mission) (get-universal-time))
    (setf (get-output mission) (funcall (get-contents mission)))
    (setf (get-result mission) :success)
    (setf (get-status mission) :end)
    (setf (get-end-time mission) (get-universal-time))
    mission))

(defun do-misson (mission)
  "call backが欲しいねぇ。"
  (setf (get-thread mission)
        (enter-thread (operation mission))))

