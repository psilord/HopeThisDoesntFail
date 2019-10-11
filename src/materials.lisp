(in-package #:hopethisdoesntfail)

(v:define-material sprite/ship-atlas
  (:profiles (x/mat:u-mvp)
   :shader htdf/shd:sprite
   :uniforms ((:sprite.sampler 'sprite/ship-atlas)
              (:opacity 1.0)
              (:alpha-cutoff 0.1))
   :blocks ((:block-name :spritesheet ;; <-- name of block var in shader!
             :storage-type :buffer
             :block-alias :htdf/ship-spritesheet
             :binding-policy :manual))))
