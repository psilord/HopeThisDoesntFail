;;;; HopeThisDoesntFail.lisp

(in-package #:hopethisdoesntfail)

;;; "HopeThisDoesntFail" goes here. Hacks and glory await!

(v:define-prefab "test-scene" (:library htdf)
  (("camera" :copy "/cameras/perspective")
   #++(c/xform:transform :translate (v3:vec 0 0 1)))

  (("cube" :copy "/mesh")
   (c/xform:transform :translate (v3:vec 0 0 0)
                      :rotate/inc (q:orient :local (v3:one) (/ pi 2))
                      :scale 10)
   (c/smesh:static-mesh :asset '(:virality.engine/mesh "cube.glb"))))


(v:define-prefab-descriptor test-scene ()
  ("test-scene" htdf))
