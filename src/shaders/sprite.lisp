(in-package #:hopethisdoesntfail.shaders)

(defstruct sprite-data
  (sampler :sampler-2d :accessor sampler)
  (index :int :accessor index))

(defstruct spritesheet-data
  (pos (:vec2 2048) :accessor pos)
  (size (:vec2 2048) :accessor size))

(defun  sprite/v ()
  (values))

(defun  sprite/g (&uniforms
                  (model :mat4)
                  (view :mat4)
                  (proj :mat4)
                  (sprite sprite-data)
                  ;; vvvvvvv The name of the block var!
                  (spritesheet spritesheet-data :ssbo :std-430))
  (declare (output-primitive :kind :triangle-strip :max-vertices 4))
  (let* ((mvp (* proj view model))
         (size (.xyxy (texture-size (sampler sprite) 0)))
         (extents (vec4 (aref (pos spritesheet) (index sprite))
                        (aref (size spritesheet) (index sprite))))
         (offsets (* size (vec4 (* 0.5 (.zw extents)) (* -0.5 (.zw extents))))))
    (setf (.zw extents) (+ (.xy extents) (.zw extents)))
    (emit ()
      (* mvp (vec4 (.xy offsets) 0 1))
      (.zw extents))
    (emit ()
      (* mvp (vec4 (.zy offsets) 0 1))
      (.xw extents))
    (emit ()
      (* mvp (vec4 (.xw offsets) 0 1))
      (.zy extents))
    (emit ()
      (* mvp (vec4 (.zw offsets) 0 1))
      (.xy extents))
    (end-primitive)))

(defun  sprite/f ((uv :vec2)
                  &uniforms
                  (opacity :float)
                  (alpha-cutoff :float)
                  (sprite sprite-data))
  (let ((color (texture (sampler sprite) uv)))
    (if (< (.a color) alpha-cutoff)
        (discard)
        (vec4 (.rgb color) opacity))))

(define-shader sprite (:primitive :points)
  (:vertex (sprite/v))
  (:geometry (sprite/g))
  (:fragment (sprite/f :vec2)))
