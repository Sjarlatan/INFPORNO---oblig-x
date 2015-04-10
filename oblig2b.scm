;; Oblig2B.scm av Benjamin A. Thomas (benjamat) og Thomas Schwitalla (thoschwi)

;; 1. Innkapsling, lokal tilstand og omgivelsesmodellen
;; a) 

(define count 42)

(define (make-counter)
  (let ((count 0))
    (lambda ()
      (begin
        (set! count (+ count 1))
        count))))

(define c1 (make-counter))
(define c2 (make-counter))

;; b) Se vedlagt "1b-omgivelse.png"


;; 2 Innkapsling, lokal tilstand og message passing.
;; a)

(define (make-stack init)
  (let ((stack init))
               
    (lambda (message . items) ;; Items er en argumentliste av variabel lengde.
      (case message
        ('pop! (if (null? stack)
                   '() ;; Aner ikke hvordan man bare gjor "ingenting"...
                   (set! stack (cdr stack))))
        ('push! (set! stack (append (reverse items) stack)))
        ('stack stack)
        (else "Invalid message!")))))

(define s1 (make-stack (list 'foo 'bar)))
(define s2 (make-stack '()))


;; b)

(define (push!)
  (lambda (message . items)
    (set! stack (append (reverse items) stack))))

;;(push! s1 'foo 'faa)

(define (pop!)
  (lambda (items)
    ('pop! (if (null? items)
           '()
           (set! items (cdr items))))))

;; 3 Strukturdeling og sirkulære lister
;; a)

(define bar (list 'a 'b 'c 'd 'e))
(set-cdr! (cdddr bar) (cdr bar))

;; b)

(define bah (list 'bring 'a 'towel))
;;(set-car! bah (cdr bah))
;;(eq? (car bah) (cdr bah))
;;bah
;;(set-car! (car bah) 42)


;; c)

(define (cycle? items) ;; Konstant minnebruk.
  (define (race tortoise hare)
    (cond ((null? hare) #f)
          ((null? (cdr hare)) #f)
          ((eq? tortoise hare) #t)
          (else (race (cdr tortoise) (cddr hare)))))
  (race items (cdr items)))

;;(cycle? '(hey ho))
;;(cycle? bar)


;; d)

;; WHY?

;; e)



(define r1 (make-ring '(1 2 3 4)))
r1

;; f)