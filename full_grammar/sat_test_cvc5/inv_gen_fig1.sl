(set-logic LIA)

(synth-fun fn0 ((vr0 Int) (vr1 Int)) Bool
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
        (abs Start)
        (ite StartBool Start Start)
        vr0 vr1))
    (Const Int (0 1 2 3 4 5 6 7 8 9))))
(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(constraint (or (not (= 0 (+ vr0 50))) (fn0 vr0 vr1)))
(constraint (or (not (and (and (and (fn0 vr0 vr1) (< vr0 0)) (= vr2 (+ vr0 vr1))) (= vr3 (+ vr1 1)))) (fn0 vr2 vr3)))
(constraint (or (not (and (fn0 vr0 vr1) (>= vr0 0))) (> vr1 0)))

(check-synth)

