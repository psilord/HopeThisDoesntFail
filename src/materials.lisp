(in-package #:hopethisdoesntfail)

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
