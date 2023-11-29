(set-logic LIA)

(synth-fun fn0 ((vr0 Int) (vr1 Int) (vr2 Int)) Int
    ((Start Int) (StartBool Bool))
    ((Start Int (vr0 vr1 vr2 0 1 (+ Start Start) (- Start Start) (ite StartBool Start Start)))
    (StartBool Bool ((and StartBool StartBool) (or StartBool StartBool) (not StartBool) (<= Start Start) (= Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(constraint (>= (fn0 vr0 vr1 vr2) vr0))
(constraint (>= (fn0 vr0 vr1 vr2) vr1))
(constraint (>= (fn0 vr0 vr1 vr2) vr2))
(constraint (or (= vr0 (fn0 vr0 vr1 vr2)) (or (= vr1 (fn0 vr0 vr1 vr2)) (= vr2 (fn0 vr0 vr1 vr2)))))

(check-synth)

