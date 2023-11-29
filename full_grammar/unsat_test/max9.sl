(set-logic LIA)

(synth-fun fn0 ((vr0 Int) (vr1 Int) (vr2 Int) (vr3 Int) (vr4 Int) (vr5 Int) (vr6 Int) (vr7 Int) (vr8 Int)) Int
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
        vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8))
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
(declare-var vr4 Int)
(declare-var vr5 Int)
(declare-var vr6 Int)
(declare-var vr7 Int)
(declare-var vr8 Int)
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr0))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr1))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr2))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr3))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr4))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr5))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr6))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr7))
(constraint (>= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8) vr8))
(constraint (or (= vr0 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr1 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr2 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr3 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr4 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr5 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr6 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (or (= vr7 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)) (= vr8 (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7 vr8)))))))))))

(check-synth)

