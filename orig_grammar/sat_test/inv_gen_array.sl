(set-logic LIA)

(synth-fun fn8 ((vr3 Int) (vr1 Int) (vr4 Int)) Bool
    ((Start Bool) (AtomicFormula Bool) (Sum Int) (Term Int) (Sign Int) (Var Int) (Const Int))
    ((Start Bool ((and AtomicFormula AtomicFormula) (or AtomicFormula AtomicFormula)))
    (AtomicFormula Bool ((<= Sum Const) (= Sum Const)))
    (Sum Int ((+ Term Term)))
    (Term Int ((* Sign Var)))
    (Sign Int (0 1 (- 1)))
    (Var Int (vr3 vr1 vr4))
    (Const Int ((- 3) (- 2) (- 1) 0 1 2 3))))

(define-fun fn0 ((b1 Bool) (b2 Bool)) Bool
    (or (not b1) b2))
(define-fun fn1 ((b1 Bool) (b2 Bool) (b3 Bool)) Bool
    (and (and b1 b2) b3))
(define-fun fn2 ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool)) Bool
    (and (fn1 b1 b2 b3) b4))
(define-fun fn3 ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool)) Bool
    (and (fn2 b1 b2 b3 b4) b5))
(define-fun fn4 ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool) (b6 Bool)) Bool
    (and (fn3 b1 b2 b3 b4 b5) b6))
(define-fun fn5 ((b1 Bool) (b2 Bool) (b3 Bool)) Bool
    (or (or b1 b2) b3))
(define-fun fn6 ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool)) Bool
    (or (fn5 b1 b2 b3) b4))
(define-fun fn7 ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool)) Bool
    (or (fn6 b1 b2 b3 b4) b5))
(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(declare-var vr4 Int)
(declare-var vr5 Int)
(declare-var vr6 Int)
(declare-var vr7 Int)
(declare-var vr8 Int)
(declare-var vr9 Int)
(declare-var vr10 Int)
(constraint (fn0 (and (= vr0 5) (= 0 vr1)) (fn8 vr3 vr1 vr4)))
(constraint (fn0 (fn4 (= vr1 0) (fn8 vr3 vr1 vr4) (< vr1 vr0) (= vr4 vr2) (or (and (<= vr4 vr3) (= vr10 vr4)) (and (> vr4 vr3) (= vr10 vr3))) (= vr9 (+ vr1 1))) (fn8 vr10 vr9 vr4)))
(constraint (fn0 (fn4 (= vr1 1) (fn8 vr3 vr1 vr4) (< vr1 vr0) (= vr5 vr2) (or (and (<= vr5 vr3) (= vr10 vr5)) (and (> vr5 vr3) (= vr10 vr3))) (= vr9 (+ vr1 1))) (fn8 vr10 vr9 vr4)))
(constraint (fn0 (fn4 (= vr1 2) (fn8 vr3 vr1 vr4) (< vr1 vr0) (= vr6 vr2) (or (and (<= vr6 vr3) (= vr10 vr6)) (and (> vr6 vr3) (= vr10 vr3))) (= vr9 (+ vr1 1))) (fn8 vr10 vr9 vr4)))
(constraint (fn0 (fn4 (= vr1 3) (fn8 vr3 vr1 vr4) (< vr1 vr0) (= vr7 vr2) (or (and (<= vr7 vr3) (= vr10 vr7)) (and (> vr7 vr3) (= vr10 vr3))) (= vr9 (+ vr1 1))) (fn8 vr10 vr9 vr4)))
(constraint (fn0 (fn4 (= vr1 4) (fn8 vr3 vr1 vr4) (< vr1 vr0) (= vr8 vr2) (or (and (<= vr8 vr3) (= vr10 vr8)) (and (> vr8 vr3) (= vr10 vr3))) (= vr9 (+ vr1 1))) (fn8 vr10 vr9 vr4)))
(constraint (fn0 (fn1 (= vr1 5) (fn8 vr3 vr1 vr4) (>= vr1 vr0)) (>= vr4 vr3)))

(check-synth)

