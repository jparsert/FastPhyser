
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

(constraint (= (f #x462de0de1125b950) #x0000000000000002))
(constraint (= (f #x23564099dc9e076d) #xfffffffffffffffd))
(constraint (= (f #xa1199b5717c3bcee) #x0000000000000002))
(constraint (= (f #x3a5ee8e4e34da67b) #xfffffffffffffffd))
(constraint (= (f #xeca686a3eaec9565) #xfffffffffffffffd))
(constraint (= (f #xcbe015cc4240ac1b) #xfffffffffffffffd))
(constraint (= (f #x6c9271a3b619b696) #x0000000000000002))
(constraint (= (f #x1bedceca48c8e033) #xfffffffffffffffd))
(constraint (= (f #xd0b46cc12deb61e0) #x0000000000000002))
(constraint (= (f #x51205ccce3ba2880) #x0000000000000002))
(check-synth)