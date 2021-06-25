#lang racket

(require plot)

(require math/base)

(define x (build-list 100 (λ (x) (random-natural 100))))
(define y (build-list 100 (λ (x) (random-natural 100))))

(plot
    (points (map vector x y))
            #:x-min 0 #:x-max 100
                        #:y-min 0 #:y-max 100)