(in-package #:hopethisdoesntfail)

(v:define-options :hopethisdoesntfail
  :window-width 960
  :window-height 1280
  :vsync :off
  :delta 1/120
  :title "Hope This Doesn't Fail"
  :initial-scene nil)

(v:define-assets :hopethisdoesntfail
  :log "log"
  :levels "Levels"
  :tex (:levels "texture")
  :log-debug (:log "debug.log")
  :log-error (:log "error.log")
  :ship-sheet (:levels "ships.tiff")
  :ship-sheet-spec (:levels "ships.spec"))

(defun start (scene-name)
  (let ((scene (a:format-symbol :hopethisdoesntfail "~:@(~a~)" scene-name)))
    (v:start :project :hopethisdoesntfail
             :scene scene)))

;; a set of stock prefabs we'll need very often.
(v:define-prefab "cameras" (:library htdf)
  ("ortho"
   (c/cam:camera :active-p t
		 :zoom 4
                 :mode :orthographic))
  ("perspective"
   (c/cam:camera :active-p t
                 :mode :perspective))
  ("iso"
   (c/xform:transform :rotate (q:orient :local
                                        :x (- (atan (/ (sqrt 2))))
                                        :y (- (/ pi 4))))
   ("camera"
    (c/xform:transform :translate (v3:vec 0 0 10))
    (c/cam:camera :active-p t
                  :mode :orthographic))))

(v:define-prefab "mesh" (:library htdf)
  (c/smesh:static-mesh :asset '(:virality.engine/mesh "plane.glb"))
  (c/render:render :material 'x/mat:unlit-texture))




;; nasty boiler plate below, but designed for this package.

(in-package #:virality.engine)

(define-graph :hopethisdoesntfail
    (:category component-dependency
     :depends-on ((:core (all-unknown-types core-types)))
     :roots (all-ordered-types))
  (subdag all-ordered-types
          ((splice core-types)
           -> (splice all-unknown-types))))

(define-graph :virality.engine
    (:category component-package-order
     :depends-on ((:core-component-order (core-packages)))
     :roots (start-search))
  (subdag current-project (:comp -> :hopethisdoesntfail))
  (subdag start-search
          ((splice current-project)
           -> (splice core-packages))))
