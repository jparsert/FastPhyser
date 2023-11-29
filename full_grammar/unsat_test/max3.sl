(set-logic LIA)

(synth-fun fn0 ((vr0 Int) (vr1 Int) (vr2 Int)) Int
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
        vr0 vr1 vr2))
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
(constraint (>= (fn0 vr0 vr1 vr2) vr0))
(constraint (>= (fn0 vr0 vr1 vr2) vr1))
(constraint (>= (fn0 vr0 vr1 vr2) vr2))
(constraint (or (= vr0 (fn0 vr0 vr1 vr2)) (or (= vr1 (fn0 vr0 vr1 vr2)) (= vr2 (fn0 vr0 vr1 vr2)))))

(check-synth)

