(set-logic LIA)

(synth-fun fn0 ((y1 Int) (y2 Int) (y3 Int) (y4 Int) (k1 Int)) Int
    ((Start Int) (BoolExpr Bool))
    ((Start Int (0 1 2 3 4 y1 y2 y3 y4 k1 (ite BoolExpr Start Start)))
    (BoolExpr Bool ((< Start Start) (<= Start Start) (> Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(declare-var vr4 Int)
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (< vr2 vr3))) (=> (< vr4 vr0) (= (fn0 vr0 vr1 vr2 vr3 vr4) 0))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (< vr2 vr3))) (=> (> vr4 vr3) (= (fn0 vr0 vr1 vr2 vr3 vr4) 4))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (< vr2 vr3))) (=> (and (> vr4 vr0) (< vr4 vr1)) (= (fn0 vr0 vr1 vr2 vr3 vr4) 1))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (< vr2 vr3))) (=> (and (> vr4 vr1) (< vr4 vr2)) (= (fn0 vr0 vr1 vr2 vr3 vr4) 2))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (< vr2 vr3))) (=> (and (> vr4 vr2) (< vr4 vr3)) (= (fn0 vr0 vr1 vr2 vr3 vr4) 3))))

(check-synth)

