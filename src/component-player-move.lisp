(in-package #:hopethisdoesntfail)

;; ;;;;;;;;;
;; Component: player-movement
;;
;; Use dpad to move around, etc.
;; ;;;;;;;;;

(v:define-component player-movement ()
  ((%transform :accessor transform
               :initarg :transform
               :initform nil)
   (%max-velocity :accessor max-velocity
                  :initarg :max-velocity
                  :initform 256f0) ;; in pixels
   ;; We just hack in a boundary cube you can't go outside of. This is in the
   ;; local space of the actor to which this component is attached.
   ;; The format is minx, maxx, miny, maxy, minz, maxz
   (%region-cuboid :accessor region-cuboid
                   :initarg :region-cuboid
                   :initform (reg:make-region-cuboid
                              (v3:vec 0f0 0f0 0f0)
                              -120f0 120f0 -160f0 160f0 0f0 0f0))))

;; upon attaching, this component will store find the transform component
;; on the actor to which it has been attached and keep a direct reference to it.
(defmethod v:on-component-attach ((self player-movement) actor)
  (declare (ignore actor))
  (with-accessors ((actor v:actor) (transform transform)) self
    (setf transform (v:component-by-type actor 'c/xform:transform))))

(defmethod v:on-component-update ((self player-movement))
  (with-accessors ((context v:context) (transform transform)
                   (max-velocity max-velocity)
                   (translate-deadzone translate-deadzone)
                   (rotate-deadzone rotate-deadzone)
                   (region-cuboid region-cuboid))
      self

    (let* ((left-p (v:input-enabled-p context '(:gamepad1 :left)))
           (right-p (v:input-enabled-p context '(:gamepad1 :right)))
           (down-p (v:input-enabled-p context '(:gamepad1 :down)))
           (up-p (v:input-enabled-p context '(:gamepad1 :up)))
           (x-intent (cond (left-p -1) (right-p 1) (t 0)))
           (y-intent (cond (down-p -1) (up-p 1) (t 0)))
           (move-direction (v3:normalize (v3:vec x-intent y-intent 0f0)))
           (move-direction (v3:scale move-direction max-velocity))
           (current-translation
             ;; TODO NOTE: Prolly should fix these to be external.
             (c/xform::current (c/xform::translation transform)))
           ;; Put into pixels per second.
           (move-direction (v3:scale move-direction (v:frame-time context)))
           ;; Finally, clip to the region.
           (move-direction (reg:clip-movement-vector move-direction
                                                     current-translation
                                                     region-cuboid)))

      (c/xform:translate transform move-direction))))
