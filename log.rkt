#lang racket

(require racket/date)


(provide set-log-level log-fatal log-error log-warning log-info log-debug )

;
(date-display-format 'rfc2822)

;
(define log-level 0)

(define (log-fatal message)
  (when (>= log-level 0) (log 'fatal message)))


(define (log-error message)
  (when (>= log-level 1) (log 'error message)))


(define (log-warning message)
  (when (>= log-level 2) (log 'warning message)))


(define (log-info message)
  (when (>= log-level 3) (log 'info message)))


(define (log-debug message)
  (when (>= log-level 4) (log 'debug message)))

(define (set-log-level level)
  (cond [(eq? level 'fatal) (set! log-level 0)]
        [(eq? level 'error) (set! log-level 1)]
        [(eq? level 'warning) (set! log-level 2)]
        [(eq? level 'info) (set! log-level 3)]
        [(eq? level 'debug) (set! log-level 4)]
        [else (set! log-level 0)]))

(define (log level message)
  (printf "# ~a ~a ~a ~n" level (date->string (current-date)) message))