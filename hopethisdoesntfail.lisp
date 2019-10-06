;;;; HopeThisDoesntFail.lisp

(in-package #:hopethisdoesntfail)

;;; "HopeThisDoesntFail" goes here. Hacks and glory await!

(v:define-texture sprite/ship-atlas (:texture-2d)
  (:texture-min-filer :nearest)
  (:texture-mag-filter :nearest)
  (:data #(:ship-sheet)))

(v:define-material sprite/ship-atlas
  (:profiles (x/mat:u-mvp)
   :shader shd/sprite:sprite
   :uniforms ((:sprite.sampler 'sprite/ship-atlas)
              (:opacity 1.0)
              (:alpha-cutoff 0.1))
   :blocks ((:block-name :spritesheet
             :storage-type :buffer
             :block-alias :spritesheet
             :binding-policy :manual))))

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
                   :initform (reg:make-region-cuboid (v3:vec 0.0 0.0 0.0)
                                                     -120 120 -160 160 0 0))))

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



(v:define-prefab "player-ship" (:library htdf)
  (player-movement)
  ("ship-body"
   (c/sprite:sprite :spec :ship-sheet-spec
                    :name "player00-00")
   (c/render:render :material 'sprite/ship-atlas
                    :mode :sprite)
   ("center-gun"
    (c/xform:transform :translate (v3:zero)))

   ("exhaust"
    (c/xform:transform :translate (v3:vec 0 -20 0))
    (c/sprite:sprite :spec :ship-sheet-spec
                     :name "player00-exhaust00-00")
    ;; TODO: When the material symbol is incorrect, the error is inscrutable.
    (c/render:render :material 'sprite/ship-atlas
                     :mode :sprite))))


(v:define-prefab "test-scene" (:library htdf)
  (("camera" :copy "/cameras/ortho")
   #++(c/xform:transform :translate (v3:vec 0 0 1)))

  (("player" :copy "/player-ship")))



(v:define-prefab-descriptor test-scene ()
  ("test-scene" htdf))
