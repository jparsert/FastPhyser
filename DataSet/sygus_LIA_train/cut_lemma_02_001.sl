; Solution: ((-var_17242238829055288884 + var_14646222335869814625) + var_14001432997027750023) + var_5641891546224084318

(set-logic LIA)
(declare-var x0 Int)

(declare-var x1 Int)

(declare-var x2 Int)

(declare-var x4 Int)

(declare-var x5 Int)

(declare-var x6 Int)

(declare-var x7 Int)

(declare-var x8 Int)

(declare-var x9 Int)

(synth-fun synthTarget((var_17242238829055288884 Int)(var_14646222335869814625 Int)(var_14001432997027750023 Int)(var_5641891546224084318 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_17242238829055288884 var_14646222335869814625 var_14001432997027750023 var_5641891546224084318 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (not (>= (+ (* x0 (- 8)) (+ (* x1 (- 8)) (+ (* x5 (- 16)) (+ (* x9 16) (+ (* x2 8) (* x8 24)))))) (- 8))) (and (and (and (and (and (and (and (and (<= (- 1) (+ (+ (+ x6 x9) (* x2 2)) x8)) (<= (+ (+ (+ (* x1 2) x0) x5) (- x7)) 0)) (<= (- x4 x9) (- 1))) (<= (+ (+ (- x8) (* x5 2)) (- x7)) 1)) (<= (- 1) (synthTarget x6 x9 (* x8 2) (- x7) ))) (<= 0 (+ (+ (- x2) x1) (- x7)))) (<= (+ (synthTarget x0 x6 x5 x8 ) (- x7)) (- 1))) (<= 0 (+ (+ (+ (+ x9 x4) x6) (- x0)) x2))) (<= 1 (+ x8 x1))))))
(check-synth)
