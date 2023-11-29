(set-logic LIA)

(synth-fun fn0 ((vr0 Int) (vr1 Int)) Int
    ((Start Int) (StartBool Bool))
    ((Start Int (vr0 vr1 0 1 (- 1) 2 (- 2) (+ Start Start) (- Start Start) (ite StartBool Start Start)))
    (StartBool Bool ((and StartBool StartBool) (or StartBool StartBool) (not StartBool) (<= Start Start) (= Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(constraint (or (and (= vr0 vr1) (= (fn0 vr0 vr1) 0)) (or (and (> vr0 vr1) (= (fn0 vr0 vr1) 1)) (= (fn0 vr0 vr1) (- 1)))))

(check-synth)

