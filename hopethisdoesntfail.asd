(asdf:defsystem #:hopethisdoesntfail
  :description "HopeThisDoesntFail is a shmup."
  :author ("Peter Keller <psilord@cs.wisc.edu>"
           "Ryan Burnside <pixeloutlaw@gmail.com>")
  :license "MIT"
  :version "0.0.0"
  :depends-on (#:alexandria
               #:golden-utils
               #:origin
               #:verbose
               #:virality.engine)
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "common")
	       (:file "textures")
	       (:file "materials")
	       (:file "component-player-move")
               (:file "hopethisdoesntfail")))
