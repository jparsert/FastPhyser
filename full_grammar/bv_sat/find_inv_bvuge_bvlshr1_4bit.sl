(set-logic BV)

(synth-fun fn6 ((vr0 (_ BitVec 4)) (vr1 (_ BitVec 4))) (_ BitVec 4)
    ((BV (_ BitVec 4)) (B Bool) (Const (_ BitVec 4))) (
    (BV (_ BitVec 4)
        (BV
        Const
        vr0 vr1
        (bvand BV BV)
        (bvor BV BV)
        (bvxor BV BV)
        (bvxnor BV BV)
        (bvnot BV)
        (bvneg BV)
        (bvadd BV BV)
        (bvsub BV BV)
        (bvmul BV BV)
        (bvsdiv BV BV)
        (bvudiv BV BV)
        (bvsrem BV BV)
        (bvsmod BV BV)
        (bvurem BV BV)
        (bvshl BV BV)
        (bvashr BV BV)
        (bvlshr BV BV)
        (ite B BV BV)))
    (B Bool
        (B
        (= BV BV)
        true
        false
        (bvult BV BV)
        (and B B)
        (or B B)
        (not B)
        (bvule BV BV)
        (bvugt BV BV)
        (bvuge BV BV)
        (bvslt BV BV)
        (bvsle BV BV)
        (bvsgt BV BV)
        (bvsge BV BV)))
    (Const (_ BitVec 4) (#x0 #x1 #xF))))
(declare-var vr0 (_ BitVec 4))
(declare-var vr1 (_ BitVec 4))
(define-fun fn0 ((a (_ BitVec 4)) (b (_ BitVec 4))) (_ BitVec 4)
    (ite (= b #x0) #xF (bvudiv a b)))
(define-fun fn1 ((a (_ BitVec 4)) (b (_ BitVec 4))) (_ BitVec 4)
    (ite (= b #x0) a (bvurem a b)))
(define-fun fn2 () (_ BitVec 4)
    (bvnot (bvlshr (bvnot #x0) #x1)))
(define-fun fn3 () (_ BitVec 4)
    (bvnot fn2))
(define-fun fn4 ((vr0 (_ BitVec 4)) (vr1 (_ BitVec 4))) Bool
    (bvuge (bvlshr vr0 (fn6 vr0 vr1)) vr1))
(define-fun fn5 ((vr0 (_ BitVec 4)) (vr1 (_ BitVec 4))) Bool
    (bvuge vr0 vr1))
(constraint (=> (fn5 vr0 vr1) (fn4 vr0 vr1)))

(check-synth)

