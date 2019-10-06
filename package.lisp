;;;; package.lisp

(in-package #:cl-user)

(defpackage #:hopethisdoesntfail
  (:use #:cl)
  (:export #:start))

(defpackage #:hopethisdoesntfail.shaders
  (:use #:shadow.glsl #:umbra.common))

(virality.nicknames:define-nicknames
  (:hopethisdoesntfail :htdf)
  (:hopethisdoesntfail.shaders :htdf/shd))
