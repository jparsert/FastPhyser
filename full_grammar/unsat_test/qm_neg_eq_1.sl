(set-logic LIA)

(define-fun fn0 ((a Int) (b Int)) Int
    (ite (< a 0) b a))
(synth-fun fn1 ((vr0 Int)) Int
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
(constraint (= (fn1 vr0) (ite (<= vr0 0) 1 0)))

(check-synth)

