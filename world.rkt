#lang racket

;
(provide create-world
         create-area
         create-node
         create-gate
         add-area-to-world
         add-node-to-area)

; a world is composed of areas
(struct World (areas) #:transparent #:mutable)

; an area is composed of nodes, areas are connected by gates
(struct Area (id nodes entities) #:transparent #:mutable)

; a node has a position
(struct Node (id type x y links) #:transparent #:mutable)

; a link allows to go from one node to another
(struct Link (n1 n2)  #:transparent)

; create a new world
(define (create-world)
  (World (make-hash)))

; add areas to the world
(define (add-area-to-world area world)
  (hash-set! (World-areas world) (Area-id area) area))

; create a new area
(define (create-area id)
  (Area id (make-hash) (make-hash)))

; add a node to an area
(define (add-node-to-area n a)
  (if (eq? empty (Area-nodes a))
      (set-Area-nodes! a (make-hash))
      '())
  (hash-set! (Area-nodes a) (Node-id n) n))

; create a node
(define (create-node id x y links)
  (Node id 'Node x y links))

; create a gate
(define (create-gate id x y links)
  (Node id 'Gate x y links))
