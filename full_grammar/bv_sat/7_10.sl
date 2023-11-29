
(set-logic BV)

(define-fun shr1 ((x (_ BitVec 64))) (_ BitVec 64) (bvlshr x #x0000000000000001))
(define-fun shr4 ((x (_ BitVec 64))) (_ BitVec 64) (bvlshr x #x0000000000000004))
(define-fun shr16 ((x (_ BitVec 64))) (_ BitVec 64) (bvlshr x #x0000000000000010))
(define-fun shl1 ((x (_ BitVec 64))) (_ BitVec 64) (bvshl x #x0000000000000001))
(define-fun if0 ((x (_ BitVec 64)) (y (_ BitVec 64)) (z (_ BitVec 64))) (_ BitVec 64) (ite (= x #x0000000000000001) y z))

(synth-fun f ((x (_ BitVec 64))) (_ BitVec 64)
    ((BV (_ BitVec 64)) (Const (_ BitVec 64))) (
    (BV (_ BitVec 64)
        (BV
        Const
        x
        (bvand BV BV)
        (bvor BV BV)
        (bvxor BV BV)
        (bvnot BV)
        (shl1 BV)
        (shr1 BV)
        (shr4 BV)
        (shr16 BV)
        (bvadd BV BV)
        (if0 BV BV BV)))
    (Const (_ BitVec 64) (#x0000000000000000 #x0000000000000001))))

(constraint (= (f #x1be88589ba201842) #xe4177a7645dfe7bd))
(constraint (= (f #x49ea2ae53e599623) #x93d455ca7cb32c46))
(constraint (= (f #xea82cc5e6104247d) #xea82cc5e6104247d))
(constraint (= (f #x75820d31bed79b87) #xeb041a637daf370e))
(constraint (= (f #xe682665199ee31a8) #x197d99ae6611ce57))
(constraint (= (f #x9d8d9c6595ee5ded) #x9d8d9c6595ee5ded))
(constraint (= (f #xad1b863e6b5351d4) #x52e479c194acae2b))
(constraint (= (f #xa7465c5c466de212) #x58b9a3a3b9921ded))
(constraint (= (f #xc287ecb0e2e8eb85) #xc287ecb0e2e8eb85))
(constraint (= (f #xac30404490729c8c) #x53cfbfbb6f8d6373))
(check-synth)