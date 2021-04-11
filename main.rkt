#lang racket

;
(require "app.rkt")


; setup application
(define (setup-app filepath)
  (displayln (string-append ">> setup app " filepath)))

; update application state
(define (update-app)
  (displayln ">> update app"))

; close application
(define (close-app)
  (displayln ">> close app"))

;
(define (main)
  ;
  (displayln ">> begin")
  (let ((filepath "c:/devs/racket/data")
        (app (new-app setup-app update-app close-app)))
    (run-app app filepath)
    )
  (displayln ">> end"))

;
(main)