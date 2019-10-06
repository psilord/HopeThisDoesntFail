(in-package #:hopethisdoesntfail)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Random Types we need, some will go into FL properly in a future date.
;; TODO: Especially these can be used to represent collision volumes and I
;; should propogate the changes into the right places.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass region ()
  ((%center :accessor center
            :initarg :center
            :initform (v3:zero))))

(defclass region-cuboid (region)
  ((%minx :accessor minx
          :initarg :minx)
   (%maxx :accessor maxx
          :initarg :maxx)
   (%miny :accessor miny
          :initarg :miny)
   (%maxy :accessor maxy
          :initarg :maxy)
   (%minz :accessor minz
          :initarg :minz)
   (%maxz :accessor maxz
          :initarg :maxz)))

(defun make-region-cuboid (center minx maxx miny maxy minz maxz)
  (make-instance 'region-cuboid
                 :center center
                 :minx (float minx 1f0)
                 :maxx (float maxx 1f0)
                 :miny (float miny 1f0)
                 :maxy (float maxy 1f0)
                 :minz (float minz 1f0)
                 :maxz (float maxz 1f0)))

(defclass region-sphere (region)
  ;; A specific type to make math faster when it is KNOWN one is using a sphere
  ;; for something.
  ((%radius :accessor radius
            :initarg :radius)))

(defun make-region-sphere (center radius)
  (make-instance 'region-sphere :center center :radius radius))

(defclass region-ellipsoid (region)
  ;; positive distances of each principal axis.
  ;; Can be used to make 2d or 3d circles, ellipses, spheres, spheroids, etc.
  ((%x :accessor x
       :initarg :x)
   (%y :accessor y
       :initarg :y)
   (%z :accessor z
       :initarg :z)))

(defun make-region-ellipsoid (center x y z)
  (make-instance 'region-ellipsoid :center center
                                   :x (float x 1f0)
                                   :y (float y 1f0)
                                   :z (float z 1f0)))


(defun clip-movement-vector (movement-vector current-translation region-cuboid)
  "Clip the MOVEMENT-VECTOR by an amount that will cause it to not violate the
REGION-CUBOID when MOVEMENT-VECTOR is added to the CURRENT-TRANSLATION.
Return a newly allocated and adjusted MOVEMENT-VECTOR."

  (with-accessors ((center center)
                   (minx minx) (maxx maxx) (miny miny) (maxy maxy)
                   (minz minz) (maxz maxz))
      region-cuboid
    (v3:with-components ((c current-translation)
                         (m movement-vector))
      ;; add the movement-vector to the current-translation
      (let* ((nx (+ cx mx))
             (ny (+ cy my))
             (nz (+ cz mz))
             ;; And the default adjustments to the movement-vector
             (adj-x 0)
             (adj-y 0)
             (adj-z 0))
        ;; Then if it violates the boundary cube, compute the adjustment we
        ;; need to the movement vector to fix it.
        (let ((offset-minx (+ (v3:x center) minx))
              (offset-maxx (+ (v3:x center) maxx))
              (offset-miny (+ (v3:y center) miny))
              (offset-maxy (+ (v3:y center) maxy))
              (offset-minz (+ (v3:z center) minz))
              (offset-maxz (+ (v3:z center) maxz)))
          (when (< nx offset-minx)
            (setf adj-x (- offset-minx nx)))

          (when (> nx offset-maxx)
            (setf adj-x (- offset-maxx nx)))

          (when (< ny offset-miny)
            (setf adj-y (- offset-miny ny)))

          (when (> ny offset-maxy)
            (setf adj-y (- offset-maxy ny)))

          (when (< nz offset-minz)
            (setf adj-z (- offset-minz nz)))

          (when (> nz offset-maxz)
            (setf adj-z (- offset-maxz nz)))

          ;; NOTE: Allocates memory.
          (v3:vec (+ mx adj-x) (+ my adj-y) (+ mz adj-z)))))))