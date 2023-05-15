; Solution: ((-var_10324134406945286825 + var_7944381446175302083) + var_4416155332026604170) + var_13279857681127647095

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

(synth-fun synthTarget((var_10324134406945286825 Int)(var_7944381446175302083 Int)(var_4416155332026604170 Int)(var_13279857681127647095 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_10324134406945286825 var_7944381446175302083 var_4416155332026604170 var_13279857681127647095 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (not (>= (+ (* x5 (- 2)) (+ (+ (* x8 4) (* x2 2)) (* x9 2))) (- 2))) (and (and (and (and (and (and (and (and (<= (- 1) (+ (+ (+ x6 x9) (* x2 2)) x8)) (<= (+ (+ (+ (* x1 2) x0) x5) (- x7)) 0)) (<= (- x4 x9) (- 1))) (<= (+ (+ (- x8) (* x5 2)) (- x7)) 1)) (<= (- 1) (synthTarget x6 x9 (* x8 2) (- x7) ))) (<= 0 (+ (+ (- x2) x1) (- x7)))) (<= (+ (synthTarget x0 x6 x5 x8 ) (- x7)) (- 1))) (<= 0 (+ (+ (+ (+ x9 x4) x6) (- x0)) x2))) (<= 1 (+ x8 x1))))))
(check-synth)
