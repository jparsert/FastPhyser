(set-logic LIA)

(synth-fun fn0 ((y1 Int) (y2 Int) (y3 Int) (k1 Int)) Int
    ((Start Int) (BoolExpr Bool))
    ((Start Int (0 1 2 3 y1 y2 y3 k1 (ite BoolExpr Start Start)))
    (BoolExpr Bool ((< Start Start) (<= Start Start) (> Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(constraint (=> (and (< vr0 vr1) (< vr1 vr2)) (=> (< vr3 vr0) (= (fn0 vr0 vr1 vr2 vr3) 0))))
(constraint (=> (and (< vr0 vr1) (< vr1 vr2)) (=> (> vr3 vr2) (= (fn0 vr0 vr1 vr2 vr3) 3))))
(constraint (=> (and (< vr0 vr1) (< vr1 vr2)) (=> (and (> vr3 vr0) (< vr3 vr1)) (= (fn0 vr0 vr1 vr2 vr3) 1))))
(constraint (=> (and (< vr0 vr1) (< vr1 vr2)) (=> (and (> vr3 vr1) (< vr3 vr2)) (= (fn0 vr0 vr1 vr2 vr3) 2))))

(check-synth)

