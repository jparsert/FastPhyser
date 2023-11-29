(set-logic LIA)

(define-fun fn0 ((a Int) (b Int)) Int
    (ite (< a 0) b a))
(synth-fun fn1 ((vr0 Int) (vr1 Int) (vr2 Int) (vr3 Int)) Int
    ((Start Int) (StartBool Bool) (Const Int)) (
    (Start Int
        (Start
        Const
        (- Start)
        (+ Start Start)
        (- Start Start)
        (* Start Const)
        (div Start Start)
        (mod Start Const)
        (abs Start)
        (ite StartBool Start Start)
        vr0 vr1 vr2 vr3))
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
    (Const Int (0 1 2 3 4 5 6 7 8 9))))
(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(constraint (= (fn1 vr0 vr1 vr2 vr3) (ite (and (and (>= vr0 vr1) (>= vr0 vr2)) (>= vr0 vr3)) vr0 (ite (and (>= vr1 vr2) (>= vr1 vr3)) vr1 (ite (>= vr2 vr3) vr2 vr3)))))

(check-synth)

