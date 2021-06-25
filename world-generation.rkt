#lang racket

(require math/base)

(require "world.rkt")

;
(define (create-random-node id x0 y0 dAng dmin dmax)
  (let* ((d (+ dmin (random-natural (- dmax dmin))))
        (aDeg (* dAng (random-natural 12)))
        (aRad (/ (/ aDeg 4) pi))
        (x (+ x0 (* d (cos aRad))))
        (y (+ y0 (* d (sin aRad)))))
  (Node id x y )))

;
(define (create-nodes nb dmin dmax)
  '())

;
(random-natural 5)
(create-random-node 1 0 0 45 300 400)
(create-random-node 1 0 0 45 300 400)
(create-random-node 1 0 0 45 300 400)
(create-random-node 1 0 0 45 300 400)
(create-random-node 1 0 0 45 300 400)
(create-random-node 1 0 0 45 300 400)
