(set-logic LIA)

(synth-fun fn0 ((NOACK Int) (acknowledgeId Int) (enabled Bool)) Bool
    ((StartBool Bool) (Start Int) (Const Int)) (
    (StartBool Bool
        (StartBool
        enabled
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
        NOACK acknowledgeId))
    (Const Int (0 1 2 3 4 5 6 7 8 9))))
(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Bool)
(constraint (=> (and (= vr0 48) (and (= vr2 true) (= vr1 48))) (= (fn0 vr0 vr1 vr2) true)))

(check-synth)

