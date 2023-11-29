(set-logic LIA)

(synth-fun fn0 ((next Int) (pos Int) (MC_741360 Bool)) Bool
    ((Start Bool) (IntExpr Int))
    ((Start Bool ((not Start) (= IntExpr IntExpr) (and Start Start) (or Start Start) MC_741360))
    (IntExpr Int (next pos 0 55 1 56 8 10 9 46))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Bool)
(constraint (and (=> (and (= vr1 9) (and (= vr0 46) (= vr2 false))) (= (fn0 vr0 vr1 vr2) true)) (and (=> (and (= vr1 8) (and (= vr0 55) (= vr2 true))) (= (fn0 vr0 vr1 vr2) true)) (=> (and (= vr2 true) (and (= vr0 56) (= vr1 10))) (= (fn0 vr0 vr1 vr2) true)))))
(constraint (and (=> (and (= vr1 9) (and (= vr0 46) (= vr2 false))) (= (fn0 vr0 vr1 vr2) true)) (and (=> (and (= vr1 8) (and (= vr0 55) (= vr2 true))) (= (fn0 vr0 vr1 vr2) true)) (=> (and (= vr2 true) (and (= vr0 56) (= vr1 10))) (= (fn0 vr0 vr1 vr2) true)))))

(check-synth)

