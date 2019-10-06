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


(v:define-prefab "player-ship" (:library htdf)
  ;;(player-movement)
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

  (("player" :copy "/player-ship"))

  #++(("cube" :copy "/mesh")
      (c/xform:transform :translate (v3:vec 0 0 0)
                         :rotate/inc (q:orient :local (v3:one) (/ pi 2))
                         :scale 10)
      (c/smesh:static-mesh :asset '(:virality.engine/mesh "cube.glb"))))


(v:define-prefab-descriptor test-scene ()
  ("test-scene" htdf))
