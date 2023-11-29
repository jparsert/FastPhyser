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
(constraint (= (fn0 0) 0))
(constraint (= (fn0 1) 10))
(constraint (= (fn0 2) 20))
(constraint (= (fn0 3) 30))
(constraint (= (fn0 4) 40))
(constraint (= (fn0 5) 50))
(constraint (= (fn0 6) 6))
(constraint (= (fn0 7) 7))
(constraint (= (fn0 8) 8))
(constraint (= (fn0 9) 9))
(constraint (= (fn0 10) 10))

(check-synth)

