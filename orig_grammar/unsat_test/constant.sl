(set-logic LIA)

(synth-fun fn0 ((vr0 Int)) Int
    ((Start Int))
    ((Start Int (vr0 0 1 (+ Start Start) (- Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(constraint (= (fn0 vr0) (fn0 vr1)))

(check-synth)

