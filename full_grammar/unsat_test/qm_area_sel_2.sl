(set-logic LIA)

(define-fun fn0 ((a Int) (b Int)) Int
    (ite (< a 0) b a))
(synth-fun fn1 ((vr0 Int) (vr1 Int) (vr2 Int) (vr3 Int) (vr4 Int) (vr5 Int)) Int
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
        vr0 vr1 vr2 vr3 vr4 vr5))
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
(constraint (= (fn1 vr0 vr1 vr2 vr3 vr4 vr5) (let ((adx (- vr0 vr2)) (ady (- vr1 vr3)) (bdx (- vr0 vr4)) (bdy (- vr1 vr5))) (let ((aax (ite (< adx 0) (- 0 adx) adx)) (aay (ite (< ady 0) (- 0 ady) ady)) (bax (ite (< bdx 0) (- 0 bdx) bdx)) (bay (ite (< bdy 0) (- 0 bdy) bdy))) (ite (< (+ aax aay) (+ bax bay)) 1 0)))))

(check-synth)

