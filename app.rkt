#lang racket

;
(provide new-app run-app)
(provide (struct-out App))

;
(log-warning "loading app module")
;
(struct App (fsetup fupdate fclose))

;
(define (new-app fsetup fupdate fclose)
  (App fsetup fupdate fclose))

;
(define (run-app an-app filepath)
  (begin
    ((App-fsetup an-app) filepath)
    ((App-fupdate an-app))
    ((App-fclose an-app))))
  
