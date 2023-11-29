
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

(constraint (= (f #xd5752ee87720d71e) #x2a8ad11788df28e1))
(constraint (= (f #xe670aad84eee5ed9) #x0000000000000001))
(constraint (= (f #xc20133e172eabe7c) #x0000000000000000))
(constraint (= (f #x57b6e71e0e176250) #x0000000000000000))
(constraint (= (f #xc39eda372131903c) #x0000000000000000))
(constraint (= (f #x4d0e212b30c5c1ab) #xb2f1ded4cf3a3e55))
(constraint (= (f #xe336c0825b34e2b6) #x1cc93f7da4cb1d49))
(constraint (= (f #x092697eb5b6b61d5) #x0000000000000001))
(constraint (= (f #x03262104ebc638b6) #xfcd9defb1439c749))
(constraint (= (f #x8e8e7ac6504aea2c) #x0000000000000000))
(check-synth)