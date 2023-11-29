(set-logic LIA)

(synth-fun fn0 ((vr0 Int)) Int
    ((Start Int) (StartBool Bool))
    ((Start Int (vr0 0 10 20 30 40 50 60 70 80 90 100 (+ Start Start) (- Start Start) (ite StartBool Start Start)))
    (StartBool Bool ((not StartBool) (= Start Start)))))

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

