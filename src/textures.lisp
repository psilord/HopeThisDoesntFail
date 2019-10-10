(in-package #:hopethisdoesntfail)

(v:define-texture sprite/ship-atlas (:texture-2d)
  (:texture-min-filer :nearest)
  (:texture-mag-filter :nearest)
  (:data #(:ship-sheet)))
