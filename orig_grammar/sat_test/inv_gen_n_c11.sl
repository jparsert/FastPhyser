(set-logic LIA)

(synth-fun fn8 ((vr0 Int) (vr1 Int)) Bool
    ((Start Bool) (AtomicFormula Bool) (Sum Int) (Term Int) (Sign Int) (Var Int) (Const Int))
    ((Start Bool ((and AtomicFormula AtomicFormula) (or AtomicFormula AtomicFormula)))
    (AtomicFormula Bool ((<= Sum Const) (= Sum Const)))
    (Sum Int ((+ Term Term)))
    (Term Int ((* Sign Var)))
    (Sign Int (0 1 (- 1)))
    (Var Int (vr0 vr1))
    (Const Int ((- 7) (- 6) (- 5) (- 4) (- 3) (- 2) (- 1) 0 1 2 3 4 5 6 7))))

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
(constraint (fn0 (= vr1 0) (fn8 vr0 vr1)))
(constraint (fn0 (fn3 (fn8 vr0 vr1) (fn0 (= vr1 4) (= vr3 0)) (fn0 (not (= vr1 4)) (= vr3 vr1)) (not (or (< vr3 0) (>= vr3 5))) (= vr4 (+ vr3 1))) (fn8 vr0 vr4)))
(constraint (fn0 (fn2 (fn8 vr0 vr1) (fn0 (= vr1 4) (= vr3 0)) (fn0 (not (= vr1 4)) (= vr3 vr1)) (or (< vr3 0) (>= vr3 5))) false))

(check-synth)

