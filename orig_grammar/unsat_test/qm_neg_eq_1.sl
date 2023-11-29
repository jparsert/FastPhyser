(set-logic LIA)

(define-fun fn0 ((a Int) (b Int)) Int
    (ite (< a 0) b a))
(synth-fun fn1 ((vr0 Int)) Int
    ((Start Int))
    ((Start Int (vr0 0 1 (- Start Start) (fn0 Start Start)))))

(declare-var vr0 Int)
(constraint (= (fn1 vr0) (ite (<= vr0 0) 1 0)))

(check-synth)

