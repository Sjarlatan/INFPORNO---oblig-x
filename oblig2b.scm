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

;; c)

;;1
(define (cycle1? items)
  (define (traverse items original)
    (if (equal? items original)
        #t
        (traverse (cdr items) original)))
  (if (null? items)
      '()
      (traverse (cdr items) (cdr items))))

;;2
(define (cycle2? items)
  (define (traverse original items)
    (if (null? items)
        (traverse (cdr original) (cdr original))
        (if (equal? items original)
            #t
            (traverse original (cdr items)))))
  (traverse items (cdr items)))

;;3
(define (cycle? items)
  (define (traverse original rest)
    (if (null? original)
        #f
        (cond ((equal? original rest) #t) ;;equal? eq?
              ((null? rest) (traverse (cdr original) (cdr original)))
              (else (traverse original (cdr rest))))))
  (traverse items (cdr items)))    
      
(cycle? '(hey ho))
;;(cycle? bar)

;;miiin taaaaenke er god, når schemekoden fakker, logikken er over alle bakker...

;; d)

;; e)

(define (make-ring items)
  (define head items)
  (define (round items)
    (if (null? (cdr items))
        (append items head);;set-cdr?
        (round (cdr items))))
  (round items))

(define r1 (make-ring '(1 2 3 4)))
r1

;; f)