(in-package #:hopethisdoesntfail)

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


;; Master "scene" that brings everytihng together.
(v:define-prefab "htdf" (:library htdf)
  (("camera" :copy "/cameras/ortho")
   #++(c/xform:transform :translate (v3:vec 0 0 1)))

  (("player" :copy "/player-ship")))



(v:define-prefab-descriptor htdf ()
  ("htdf" htdf))
