(set-logic LIA)

(synth-fun fn0 ((vr0 Int)) Int
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
        vr0))
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
(constraint (= (fn0 vr0) (fn0 vr1)))

(check-synth)

