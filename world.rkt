#lang racket

; interface
(provide create-world
         create-area
         create-node
         create-gate
         add-area-to-world
         add-node-to-area
         create-entity-in-area)

; a world is composed of areas
(struct World (areas) #:transparent #:mutable)

; an area has an id and is composed of nodes, areas are connected by gates
(struct Area (id nodes entities) #:transparent #:mutable)

; a node has an id, a type (gate/node), a position (x, y) and a list of links to other nodes
(struct Node (id type x y links) #:transparent #:mutable)

; an entity has an id, a type, a position relative to a node (dx, dy)
(struct Entity (id type class node-id dx dy) #:transparent #:mutable)

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
  (hash-set! (Area-nodes a) (Node-id n) n))

; create a node
(define (create-node id x y links)
  (Node id 'Node x y links))

; create a gate
(define (create-gate id x y links)
  (Node id 'Gate x y links))

; create an entity and attach it to an area
(define (create-entity-in-area id type class node-id dx dy area)
  (let ((entity (Entity id type class node-id dx dy)))
    (hash-set! (Area-entities area) id entity)))

