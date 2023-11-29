(set-logic LIA)

(define-fun fn0 ((a Int) (b Int)) Int
    (ite (< a 0) b a))
(synth-fun fn1 ((vr0 Int) (vr1 Int) (vr2 Int) (vr3 Int) (vr4 Int)) Int
    ((Start Int))
    ((Start Int (vr0 vr1 vr2 vr3 vr4 0 1 (- Start Start) (fn0 Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(declare-var vr4 Int)
(constraint (= (fn1 vr0 vr1 vr2 vr3 vr4) (ite (and (< vr0 0) (and (< vr1 0) (and (< vr2 0) (and (< vr3 0) (< vr4 0))))) 1 0)))

(check-synth)

