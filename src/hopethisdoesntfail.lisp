(in-package #:hopethisdoesntfail)

(v:define-prefab "player-ship" (:library htdf)
  (player-movement)
  ("ship-body"
   (sprite :spec :ship-sheet-spec
           :name "player00-00")
   (c/render:render :material 'sprite/ship-atlas
                    :mode (list :explicit
                                (v:ref :self :component 'sprite)
                                #'draw-sprite))
   ("center-gun"
    (c/xform:transform :translate (v3:zero)))

   ("exhaust"
    (c/xform:transform :translate (v3:vec 0 -20 0))
    (sprite :spec :ship-sheet-spec
            :name "player00-exhaust00-00")
    ;; TODO: When the material symbol is incorrect, the error is inscrutable.
    (c/render:render :material 'sprite/ship-atlas
                     :mode (list :explicit
                                 (v:ref :self :component 'sprite)
                                 #'draw-sprite)))))

(v:define-prefab "calibrate-gamepad" (:library htdf)
  (calibrate-gamepad
   :left-analog-stick-start-position (v3:vec -30f0 0f0 0f0)
   :left-analog-stick-max-displacement 10f0
   :left-analog-stick-transform (v:ref "left-analog-stick"
                                       :component 'c/xform:transform)
   :right-analog-stick-start-position (v3:vec 30f0 0f0 0f0)
   :right-analog-stick-max-displacement 10f0
   :right-analog-stick-transform (v:ref "right-analog-stick"
                                        :component 'c/xform:transform)

   :dpad-start-position (v3:vec 0f0 0f0 0f0)
   :dpad-max-displacement 10f0
   :dpad-transform (v:ref "dpad" :component 'c/xform:transform))

  (("left-analog-stick" :copy "/mesh"))
  (("dpad" :copy "/mesh"))
  (("right-analog-stick" :copy "/mesh")))



;; Master "scene" that brings everytihng together.
(v:define-prefab "htdf" (:library htdf)
  (("camera" :copy "/cameras/ortho")
   #++(c/xform:transform :translate (v3:vec 0 0 1)))
  (("player" :copy "/player-ship")))



(v:define-prefab "htdf-calibrate-gamepad" (:library htdf)
  (("camera" :copy "/cameras/ortho"))
  (("calibrate-gamepad" :copy "/calibrate-gamepad")))


(v:define-prefab-descriptor htdf ()
  ("htdf" htdf))

(v:define-prefab-descriptor htdf-calibrate-gamepad ()
  ("htdf-calibrate-gamepad" htdf))
