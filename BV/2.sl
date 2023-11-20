(set-logic LIA)

(synth-fun fn0 ((y1 Int) (y2 Int) (k1 Int)) Int
    ((Start Int) (BoolExpr Bool))
    ((Start Int (0 1 2 y1 y2 k1 (ite BoolExpr Start Start)))
    (BoolExpr Bool ((< Start Start) (<= Start Start) (> Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(constraint (=> (< vr0 vr1) (=> (< vr2 vr0) (= (fn0 vr0 vr1 vr2) 0))))
(constraint (=> (< vr0 vr1) (=> (> vr2 vr1) (= (fn0 vr0 vr1 vr2) 2))))
(constraint (=> (< vr0 vr1) (=> (and (> vr2 vr0) (< vr2 vr1)) (= (fn0 vr0 vr1 vr2) 1))))

(check-synth)

