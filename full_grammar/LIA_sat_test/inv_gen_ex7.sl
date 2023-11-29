(set-logic LIA)

(synth-fun fn8 ((vr0 Int) (vr2 Int) (vr3 Int)) Bool
    ((StartBool Bool) (Start Int) (Const Int)) (
    (StartBool Bool
        (StartBool
        (> Start Start)
        (= Start Start)
        (< Start Start)
        (>= Start Start)
        (<= Start Start)
        (and StartBool StartBool)
        (or StartBool StartBool)
        (not StartBool)
        true
        false))
    (Start Int
        (Start
        Const
        (- Start)
        (+ Start Start)
        (- Start Start)
        (* Start Const)
        (div Start Const)
        (mod Start Const)
        (abs Start)
        (ite StartBool Start Start)
        vr0 vr2 vr3))
    (Const Int (0 1 2 3 4 5 6 7 8 9))))
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
(constraint (fn0 (fn5 (< vr1 0) (< vr2 0) (> vr2 vr1)) true))
(constraint (fn0 (fn1 (not (fn5 (< vr1 0) (< vr2 0) (> vr2 vr1))) (= vr3 vr1) (= vr0 0)) (fn8 vr0 vr2 vr3)))
(constraint (fn0 (fn2 (fn8 vr0 vr2 vr3) (< vr0 vr2) (not (or (< vr0 0) (>= vr0 vr3))) (= vr4 (+ vr0 1))) (fn8 vr4 vr2 vr3)))
(constraint (fn0 (fn1 (fn8 vr0 vr2 vr3) (< vr0 vr2) (or (< vr0 0) (>= vr0 vr3))) false))

(check-synth)

