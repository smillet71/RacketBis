#lang racket

(require math/base)

; an area is composed of nodes, areas are connected by gates
(struct Area (id nodes links gates) #:transparent)

; a node has a position
(struct Node (id x y ) #:transparent)

; a link allows to go from one node to another
(struct Link (n1 n2)  #:transparent)

;
(define (create-node id x0 y0 dAng dmin dmax)
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
(create-node 1 0 0 45 300 400)
(create-node 1 0 0 45 300 400)
(create-node 1 0 0 45 300 400)
(create-node 1 0 0 45 300 400)
(create-node 1 0 0 45 300 400)
(create-node 1 0 0 45 300 400)

;
(define (new-vv n m)
  (let ((a (lambda (i) (make-vector m))))
    (build-vector n a)))

;
(define (vv-set! a i j v)
  (vector-set! (vector-ref a i) j v))

;
(define (vv-ref a i j)
  (vector-ref (vector-ref a i) j))

