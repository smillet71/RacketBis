#lang racket

(require "log.rkt")
;
(provide new-app run-app)
(provide (struct-out App))

;
;
(struct App (fsetup fupdate fclose))

;
(define (new-app fsetup fupdate fclose)
  (log-info ">> creating new app")
  (App fsetup fupdate fclose))

;
(define (run-app an-app filepath)
  (begin
    (log-info ">> setting up app")
    ((App-fsetup an-app) filepath)
    (log-info ">> running app ")
    ((App-fupdate an-app))
    (log-info ">> closing app")
    ((App-fclose an-app))))
  
