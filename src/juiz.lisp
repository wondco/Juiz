(in-package :juiz)

(defun utime2str (utime)
  (multiple-value-bind (second minute hour date month year day daylight-p zone)
      (decode-universal-time utime)
    (declare (ignore day daylight-p))
    (format nil "~a-~a-~a ~a:~a:~a (~a)"
            year month date
            hour minute second
            zone)))


(defun make-juiz (name)
  (make-instance 'juiz :name name))

(defun make-slecao (name)
  (make-instance 'slecao :name name))


(defun default-thread-name ()
  (format nil "From juiz. ~a enterd."
          (utime2str (get-universal-time))))


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
    (handler-case
        (progn (setf (get-output mission) (funcall (get-contents mission)))
               (setf (get-result mission) :success))
      (error (c)
        (progn (setf (get-output mission) c)
               (setf (get-result mission) :faild))))
    (setf (get-status mission) :end)
    (setf (get-end-time mission) (get-universal-time))
    mission))


(defun do-misson (mission)
  "call backが欲しいねぇ。"
  (setf (get-thread mission)
        (enter-thread (operation mission))))



(defmethod mission2ht ((mission mission))
  (alexandria:alist-hash-table
   `((:slecao       . ,(get-name (get-slecao mission)))
     (:juiz         . ,(get-name (get-juiz mission)))
     (:contents     . ,(get-contents mission))
     (:status       . ,(get-status mission))
     (:result      . ,(get-result mission))
     (:output      . ,(get-output mission))
     (:receipt-time . ,(get-receipt-time mission))
     (:thread       . ,(format nil "~a" (get-thread mission)))
     (:start-time   . ,(get-start-time mission))
     (:end-time     . ,(get-end-time mission)))))
