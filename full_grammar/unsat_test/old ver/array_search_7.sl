(set-logic LIA)

(synth-fun fn0 ((y1 Int) (y2 Int) (y3 Int) (y4 Int) (y5 Int) (y6 Int) (y7 Int) (k1 Int)) Int
    ((Start Int) (BoolExpr Bool))
    ((Start Int (0 1 2 3 4 5 6 7 y1 y2 y3 y4 y5 y6 y7 k1 (ite BoolExpr Start Start)))
    (BoolExpr Bool ((< Start Start) (<= Start Start) (> Start Start) (>= Start Start)))))

(declare-var vr0 Int)
(declare-var vr1 Int)
(declare-var vr2 Int)
(declare-var vr3 Int)
(declare-var vr4 Int)
(declare-var vr5 Int)
(declare-var vr6 Int)
(declare-var vr7 Int)
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (< vr7 vr0) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 0))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (> vr7 vr6) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 7))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (and (> vr7 vr0) (< vr7 vr1)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 1))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (and (> vr7 vr1) (< vr7 vr2)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 2))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (and (> vr7 vr2) (< vr7 vr3)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 3))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (and (> vr7 vr3) (< vr7 vr4)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 4))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (and (> vr7 vr4) (< vr7 vr5)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 5))))
(constraint (=> (and (< vr0 vr1) (and (< vr1 vr2) (and (< vr2 vr3) (and (< vr3 vr4) (and (< vr4 vr5) (< vr5 vr6)))))) (=> (and (> vr7 vr5) (< vr7 vr6)) (= (fn0 vr0 vr1 vr2 vr3 vr4 vr5 vr6 vr7) 6))))

(check-synth)

