(set-logic LIA)

(synth-fun fn0 ((j Int) (MC_741360 Int)) Bool
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
        (div Start Start)
        (mod Start Const)
        (abs Start)
        (ite StartBool Start Start)
        j MC_741360))
    (Const Int (0 1 2 3 4 5 6 7 8 9))))
(declare-var vr0 Int)
(declare-var vr1 Int)
(constraint (and (=> (and (= vr0 2) (= vr1 3)) (= (fn0 vr0 vr1) true)) (=> (and (= vr1 3) (= vr0 2)) (= (fn0 vr0 vr1) true))))

(check-synth)

