#lang racket

(require racket/gui/base)
(require racket/format)

(define frame (new frame%
                   [label "Example"]
                   [width 800]
                   [height 600]))
;(send frame fullscreen #t)

; hexmap structure
(struct hexagon (a b c path) #:transparent #:mutable)


; 
(define (init-hexagon sidelength)
  (let* ((c sidelength)
         (a (/ c 2.0))
         (b (* (sin (/ pi 3.0)) c))
         (hex (new dc-path%)))
    (send hex move-to 0 b)
    (send hex line-to a 0)
    (send hex line-to (+ a c) 0)
    (send hex line-to (* 2 c) b)
    (send hex line-to (+ a c) (* 2 b))
    (send hex line-to a (* 2 b))
    (send hex line-to 0 b)
    (send hex close)
    (hexagon a b c hex)))

;
(define (hexagon-dxy hex i j)
  (let* ((a (hexagon-a hex))
         (b (hexagon-b hex))
         (c (hexagon-c hex))
         (dy (if (odd? i)  b 0)))
    (list (* i (+ c a)) (+ dy (* j (* 2 b))))))

;
(define text-font (make-font #:size 4
                             #:family 'system))
;
(define (draw-hexagon dc x y i j hex)
  (let* ((dxy (hexagon-dxy hex i j))
         (dx (+ x (first dxy)))
         (dy (+ y (second dxy))))
    (send dc set-pen "black" 2 'solid)
    (send dc set-smoothing 'smoothed)
    (send dc translate dx dy)
    (send dc draw-path (hexagon-path hex))
    (send dc set-font text-font)
    (send dc draw-text (string-append (~a i) "," (~a j)) (hexagon-a hex) (hexagon-b hex))
    (send dc translate (- dx) (- dy))))
	
(define canvas (new canvas% [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       (let ((hex (init-hexagon 10)))
                         (send dc set-scale 3 3)
                         (send dc set-text-foreground "blue")
                         (send dc draw-text "Don't Panic!" 0 0)
                         (draw-hexagon dc 100 100 0 0 hex)
                         (draw-hexagon dc 100 100 1 0 hex)
                         (draw-hexagon dc 100 100 0 1 hex)
                         (draw-hexagon dc 100 100 0 2 hex)
                         (draw-hexagon dc 100 100 0 3 hex)
                         (draw-hexagon dc 100 100 2 0 hex)
                         (draw-hexagon dc 100 100 3 0 hex)
                         (draw-hexagon dc 100 100 4 0 hex)
                         (draw-hexagon dc 100 100 1 1 hex)
                         (draw-hexagon dc 100 100 -1 -1 hex)
                         ))]))
(send frame show #t)