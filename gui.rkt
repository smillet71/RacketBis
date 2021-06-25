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
        
; initialize hexmap structure from side length
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

; positionnement relatif à l'origine d'un hexagone
(define (hexagon-dxy hex i j)
  (let* ((a (hexagon-a hex))
         (b (hexagon-b hex))
         (c (hexagon-c hex))
         (dy (if (odd? i)  b 0)))
    (list (* i (+ c a)) (+ dy (* j (* 2 b))))))

;
(define text-font (make-font #:size 3
                             #:family 'system))

; placement d'un texte pour le centrer.
(define (get-text-dxy dc txt)
  (define-values (width height a b) (send dc get-text-extent txt))
  (list (/ width 2.0) (/ height 2.0)))

; dessiner un hexagone i,j avec la définition hex par rapport à une origine en x,y 
(define (draw-hexagon dc x y i j hex)
  (send dc set-font text-font)
  (let* ((dxy (hexagon-dxy hex i j))
         (dx (+ x (first dxy)))
         (dy (+ y (second dxy)))
         (txt (string-append (~a i) "," (~a j)))
         (etxt (get-text-dxy dc txt))
         (txt-dx (first etxt))
         (txt-dy (second etxt)))
    (send dc set-pen "black" 2 'solid)
    (send dc set-smoothing 'smoothed)
    (send dc translate dx dy)
    (send dc draw-path (hexagon-path hex))
    (displayln (list txt txt-dx txt-dy))
    (send dc draw-text txt (- (hexagon-c hex) txt-dx) (- (hexagon-b hex) txt-dy ))
    (send dc translate (- dx) (- dy))))

; initialization canvas et tracé pour test
(define canvas (new canvas% [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       (let ((hex (init-hexagon 10)))
                         (send dc set-scale 2 2)
                         (send dc set-text-foreground "blue")
                         (send dc draw-text "Don't Panic!" 0 0)
                         (draw-hexagon dc 100 100 0 0 hex)
                         (draw-hexagon dc 100 100 1 0 hex)
                         (draw-hexagon dc 100 100 0 1 hex)
                         (draw-hexagon dc 100 100 0 2 hex)
                         (draw-hexagon dc 100 100 0 3 hex)
                         (draw-hexagon dc 100 100 2 1 hex)
                         (draw-hexagon dc 100 100 2 0 hex)
                         (draw-hexagon dc 100 100 3 0 hex)
                         (draw-hexagon dc 100 100 4 0 hex)
                         (draw-hexagon dc 100 100 1 1 hex)
                         (draw-hexagon dc 100 100 -1 0 hex)
                         (draw-hexagon dc 100 100 0 -1 hex)
                         (draw-hexagon dc 100 100 1 -1 hex)
                         (draw-hexagon dc 100 100 -1 -1 hex)
                         ))]))

; show the test fram with the canvas
(send frame show #t)