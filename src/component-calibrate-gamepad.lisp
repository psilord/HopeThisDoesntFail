(in-package #:hopethisdoesntfail)


(v:define-component calibrate-gamepad ()
  ((%left-analog-stick-start-position
    :accessor left-analog-stick-start-position
    :initarg :left-analog-stick-start-position)
   (%left-analog-stick-max-displacement
    :accessor left-analog-stick-max-displacement
    :initarg :left-analog-stick-max-displacement)
   (%left-analog-stick-transform
    :accessor left-analog-stick-transform
    :initarg :left-analog-stick-transform)

   (%right-analog-stick-start-position
    :accessor right-analog-stick-start-position
    :initarg :right-analog-stick-start-position)
   (%right-analog-stick-max-displacement
    :accessor right-analog-stick-max-displacement
    :initarg :right-analog-stick-max-displacement)
   (%right-analog-stick-transform
    :accessor right-analog-stick-transform
    :initarg :right-analog-stick-transform)

   (%dpad-start-position
    :accessor dpad-start-position
    :initarg :dpad-start-position)
   (%dpad-max-displacement
    :accessor dpad-max-displacement
    :initarg :dpad-max-displacement)
   (%dpad-transform
    :accessor dpad-transform
    :initarg :dpad-transform)

   ))





(defmethod v:on-component-update ((self calibrate-gamepad))
  (with-accessors
        ((context v:context)
         (left-analog-stick-start-position left-analog-stick-start-position)
         (left-analog-stick-max-displacement left-analog-stick-max-displacement)
         (left-analog-stick-transform left-analog-stick-transform)
         (right-analog-stick-start-position right-analog-stick-start-position)
         (right-analog-stick-max-displacement right-analog-stick-max-displacement)
         (right-analog-stick-transform right-analog-stick-transform)

         (dpad-start-position dpad-start-position)
         (dpad-max-displacement dpad-max-displacement)
         (dpad-transform dpad-transform))


      self
    (u:mvlet*
        ((lx ly (v:get-gamepad-analog context '(:gamepad1 :left-stick)))
         (rx ry (v:get-gamepad-analog context '(:gamepad1 :right-stick)))

         (tx ty (v:get-gamepad-analog context '(:gamepad1 :triggers)))

         (left-p (v:input-enabled-p context '(:gamepad1 :left)))
         (right-p (v:input-enabled-p context '(:gamepad1 :right)))
         (down-p (v:input-enabled-p context '(:gamepad1 :down)))
         (up-p (v:input-enabled-p context '(:gamepad1 :up)))
         (x-intent (cond (left-p -1f0) (right-p 1f0) (t 0f0)))
         (y-intent (cond (down-p -1f0) (up-p 1f0) (t 0f0)))
         (dpad-displacement (v3:normalize (v3:vec x-intent y-intent 0f0)))
         (dpad-displacement (v3:scale dpad-displacement
                                      dpad-max-displacement))

         (a-p (v:input-enabled-p context '(:gamepad1 :a)))
         (b-p (v:input-enabled-p context '(:gamepad1 :b)))
         (x-p (v:input-enabled-p context '(:gamepad1 :x)))
         (y-p (v:input-enabled-p context '(:gamepad1 :y)))
         (back-p (v:input-enabled-p context '(:gamepad1 :back)))
         (guide-p (v:input-enabled-p context '(:gamepad1 :guide)))
         (start-p (v:input-enabled-p context '(:gamepad1 :start)))
         (lsb-p (v:input-enabled-p context '(:gamepad1 :left-stick-button)))
         (rsb-p (v:input-enabled-p context '(:gamepad1 :right-stick-button)))
         (lsh-p (v:input-enabled-p context '(:gamepad1 :left-shoulder)))
         (rsh-p (v:input-enabled-p context '(:gamepad1 :right-shoulder))))


      ;; Process left analog joystick
      (c/xform:translate
       left-analog-stick-transform
       (v3:+ left-analog-stick-start-position
             (v3:scale (v3:vec lx ly 0f0)
                       left-analog-stick-max-displacement))
       :instant-p t :replace-p t)

      ;; Process right analog joystick
      (c/xform:translate
       right-analog-stick-transform
       (v3:+ right-analog-stick-start-position
             (v3:scale (v3:vec rx ry 0f0)
                       right-analog-stick-max-displacement))
       :instant-p t :replace-p t)

      ;; Process dpad
      (c/xform:translate dpad-transform
                         (v3:+ dpad-start-position dpad-displacement)
                         :instant-p t :replace-p t)

      )))
