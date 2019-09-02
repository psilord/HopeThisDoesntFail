;;;; package.lisp

(defpackage #:hopethisdoesntfail
  (:use #:cl))

(defpackage #:hopethisdoesntfail.shaders
  (:use #:cl #:vari #:virality.shaders))

(virality.nicknames:define-nicknames
    (:virality.shaders :v/shd))
