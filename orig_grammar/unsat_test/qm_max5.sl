(set-logic LIA)

(define-fun fn0 ((a Int) (b Int)) Int
    (ite (< a 0) b a))
(synth-fun fn1 ((vr0 Int) (vr1 Int) (vr2 Int) (vr3 Int) (vr4 Int)) Int
    ((Start Int))
    ((Start Int (vr0 vr1 vr2 vr3 vr4 0 1 (- Start Start) (+ Start Start) (fn0 Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(declare-var vr4 Int)
(constraint (= (fn1 vr0 vr1 vr2 vr3 vr4) (ite (and (and (and (>= vr0 vr1) (>= vr0 vr2)) (>= vr0 vr3)) (>= vr0 vr4)) vr0 (ite (and (and (>= vr1 vr2) (>= vr1 vr3)) (>= vr1 vr4)) vr1 (ite (and (>= vr2 vr3) (>= vr2 vr4)) vr2 (ite (>= vr3 vr4) vr3 vr4))))))

(check-synth)

