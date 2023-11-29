(set-logic LIA)

(synth-fun fn0 ((y1 Int) (y2 Int) (y3 Int) (y4 Int) (y5 Int) (k1 Int)) Int
    ((Start Int) (BoolExpr Bool))
    ((Start Int (0 1 2 3 4 5 y1 y2 y3 y4 y5 k1 (ite BoolExpr Start Start)))
    (BoolExpr Bool ((< Start Start) (<= Start Start) (> Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(declare-var vr4 Int)
(declare-var vr5 Int)
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (< vr3 vr4)))) (=> (< vr5 vr0) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5) 0))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (< vr3 vr4)))) (=> (> vr5 vr4) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5) 5))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (< vr3 vr4)))) (=> (and (> vr5 vr0) (< vr5 vr1)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5) 1))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (< vr3 vr4)))) (=> (and (> vr5 vr1) (< vr5 vr2)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5) 2))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (< vr3 vr4)))) (=> (and (> vr5 vr2) (< vr5 vr3)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5) 3))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (< vr3 vr4)))) (=> (and (> vr5 vr3) (< vr5 vr4)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5) 4))))

(check-synth)

