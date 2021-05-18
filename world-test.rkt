#lang racket


(require "world.rkt")

; create a new world
(define world (create-world))

; define and populate area1 with 1 Gate and 3 nodes
(let ((area1 (create-area 1))
      (ep1 (create-entity-position 100 5 -10))
      (ep2 (create-entity-position 100 4.5 -11)))
  (add-node-to-area (create-gate -1 100 0 (list -2 100)) area1)
  (add-node-to-area (create-node 100 0 0 (list -1 101 102)) area1)
  (add-node-to-area (create-node 101 0 50 (list 100)) area1)
  (add-node-to-area (create-node 102 0 -50 (list 100)) area1)
  (create-entity-in-area 1000 'red 'Ship 'CargoShip ep1 area1)
  (create-entity-in-area 1001 'red 'Ship 'PoliceShip ep2 area1)
  (add-area-to-world area1 world))

; define and populate area2 with 1 Gate and 4 nodes
(let ((area2 (create-area 2)))
  (add-node-to-area (create-gate -2 -100 0 (list -1 100)) area2)
  (add-node-to-area (create-node 100 0 0 (list -2 101 102 103)) area2)
  (add-node-to-area (create-node 101 25 25 (list 100)) area2)
  (add-node-to-area (create-node 102 -15 -30 (list 100)) area2)
  (add-node-to-area (create-node 103 15 40 (list 100)) area2)
  (add-area-to-world area2 world))

; update cyclicly the entity
(define area1 (get-world-area world 1))
(define entities (Area-entities area1))
(hash-map entities (lambda (id e) (displayln (list id e))))
