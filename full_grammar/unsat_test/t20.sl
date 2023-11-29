(set-logic LIA)

(synth-fun fn0 ((next Int) (pos Int) (MC_741360 Bool)) Bool
    ((StartBool Bool) (Start Int) (Const Int)) (
    (StartBool Bool
        (StartBool
        MC_741360
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
        next pos))
    (Const Int (0 1 2 3 4 5 6 7 8 9))))
(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Bool)
(constraint (and (=> (and (= vr1 9) (and (= vr0 46) (= vr2 false))) (= (fn0 vr0 vr1 vr2) true)) (and (=> (and (= vr1 8) (and (= vr0 55) (= vr2 true))) (= (fn0 vr0 vr1 vr2) true)) (=> (and (= vr2 true) (and (= vr0 56) (= vr1 10))) (= (fn0 vr0 vr1 vr2) true)))))
(constraint (and (=> (and (= vr1 9) (and (= vr0 46) (= vr2 false))) (= (fn0 vr0 vr1 vr2) true)) (and (=> (and (= vr1 8) (and (= vr0 55) (= vr2 true))) (= (fn0 vr0 vr1 vr2) true)) (=> (and (= vr2 true) (and (= vr0 56) (= vr1 10))) (= (fn0 vr0 vr1 vr2) true)))))

(check-synth)

