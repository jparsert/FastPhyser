(set-logic LIA)

(synth-fun fn0 ((NOACK Int) (acknowledgeId Int) (enabled Bool)) Bool
    ((Start Bool) (IntExpr Int))
    ((Start Bool ((and Start Start) (= IntExpr IntExpr) (not Start) (or Start Start) enabled))
    (IntExpr Int (NOACK acknowledgeId 0 1))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Bool)
(constraint (=> (and (= vr0 48) (and (= vr2 true) (= vr1 48))) (= (fn0 vr0 vr1 vr2) true)))

(check-synth)

