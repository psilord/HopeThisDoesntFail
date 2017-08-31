;;;; HopeThisDoesntFail.asd

(defpackage #:hopethisdoesntfail-asd
  (:use :cl :asdf))

(in-package #:hopethisdoesntfail-asd)

(asdf:defsystem #:hopethisdoesntfail
  :description "Describe HopeThisDoesntFail here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :components ((:file "package")
               (:file "hopethisdoesntfail")))

