(set-logic LIA)

(synth-fun fn0 ((vr0 Int) (vr1 Int)) Int
    ((Start Int))
    ((Start Int (vr0 vr1 (+ Start Start) (- Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(constraint (= (fn0 vr0 vr1) (fn0 vr1 vr0)))

(check-synth)

