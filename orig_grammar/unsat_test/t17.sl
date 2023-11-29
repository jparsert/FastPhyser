(set-logic LIA)

(synth-fun fn0 ((j Int) (MC_741360 Int)) Bool
    ((Start Bool) (IntExpr Int))
    ((Start Bool ((= IntExpr IntExpr)))
    (IntExpr Int ((+ IntExpr IntExpr) (- IntExpr IntExpr) j MC_741360 0 1))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(constraint (and (=> (and (= vr0 2) (= vr1 3)) (= (fn0 vr0 vr1) true)) (=> (and (= vr1 3) (= vr0 2)) (= (fn0 vr0 vr1) true))))

(check-synth)

