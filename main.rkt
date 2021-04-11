#lang racket

;
(require "app.rkt")
(require "log.rkt")

; setup application
(define (setup-app filepath)
  (log-info (string-append "  - setup file path: " filepath)))

; update application state
(define (update-app)
  (log-info ">> update app"))

; close application
(define (close-app)
  (log-info ">> close app"))

;
(define (main)
  ;
  (set-log-level 'debug)
  (log-info ">> begin")
  (let ((filepath "c:/devs/racket/data")
        (app (new-app setup-app update-app close-app)))
    (run-app app filepath)
    )
  (log-info ">> end"))

;
(main)