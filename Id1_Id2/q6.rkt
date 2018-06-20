#lang racket
(require racket/sandbox)
(require racket/exn)
(provide (all-defined-out))


;; Signature: take(lz-lst,n)
;; Type: [LzL*Number -> List]
;; If n > length(lz-lst) then the result is lz-lst as a List
(define take
  (lambda (lz-lst n)
    (if (or (= n 0) (empty-lzl? lz-lst))
      empty-lzl
      (cons (head lz-lst)
            (take (tail lz-lst) (- n 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 1: The lazy lists interface ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define cons-lzl cons)

(define empty-lzl empty)

(define empty-lzl? empty?)

(define head car)

(define tail
  (lambda (lz-lst)
    ((cdr lz-lst))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 2: Auxiliary functions for testing ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Signature: check-inf-loop(mission)
; Purpose: check if the result is infinite loop,
;          if so, return 'infinite
;          otherwise the actual result
; Type: [[Empty -> T1] -> Union(T1, Symbol)]
(define check-inf-loop
  (lambda (mission)
    (with-handlers ([exn:fail:resource?
                     (lambda (e)
                       (if (equal? (exn->string e)
                                   "with-limit: out of time\n")
                           'infinite
                           'error))])
      (call-with-limits 1 #f mission))))

; A function that creates an infinite loop
(define (inf x) (inf x))

;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 3: The assignment ;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(define lazy-append-to-all-subsets
  (lambda (item lazy-list)
    (if (empty-lzl? lazy-list)
        (cons-lzl (cons item empty-lzl) (lambda () empty-lzl))
        (cons-lzl (cons item (head lazy-list))
                            (lambda ()(lazy-append-to-all-subsets item (tail lazy-list)))))
     ))
     
         
(define join-lazy (lambda (lzl1 lzl2)
  (cond [(empty-lzl? lzl1) lzl2]
        [(empty-lzl? lzl2) lzl1]
        [else
         (cons-lzl (head lzl1) (lambda () 
               (cons-lzl (head lzl2) (lambda () 
                     (join-lazy (tail lzl1) (tail lzl2))
                     ))))
         ])
  ))
; Signature: all-subs(long)
; Type: [List(T) -> LZL(List(T))]
; Purpose: compute all lists that can be obtained 
; from long by removing items from it.
; Pre-conditions: -
; Tests:
; (take (all-subs '(1 2 3)) 8) ->
; '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
(define all-subs
  (lambda (long)
    (if (empty? long)
        (cons-lzl '() (lambda () empty-lzl)) ;return a lazy list containing only an empty list
        (let ([head (head long)]
              [recursive-subsets (all-subs (cdr long))])
          (join-lazy recursive-subsets (lazy-append-to-all-subsets head recursive-subsets))
              ))))
    ;; Your code here 



(take (all-subs '(1 2 3)) 8)
;;;;;;;;;;;;;;;;;;;;;
; Part 4: The tests ;
;;;;;;;;;;;;;;;;;;;;;

;; Make sure to add take or another utility to test here
;; If the results are obained in a different order, change the test accordingly.
(check-inf-loop (lambda () (take (all-subs '(1 2 3)) 8)))
;; Write more tests - at least 5 tests.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 5: The tests expected results;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
> (check-inf-loop (lambda () (take (all-subs '(1 2 3)) 8))
'(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
|#