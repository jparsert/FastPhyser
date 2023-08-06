; Solution: ((-var_12270410737288146201 + var_9602219798869790067) + var_9892710435246591975) + var_14430898296351729401

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

(synth-fun synthTarget((var_12270410737288146201 Int)(var_9602219798869790067 Int)(var_9892710435246591975 Int)(var_14430898296351729401 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_12270410737288146201 var_9602219798869790067 var_9892710435246591975 var_14430898296351729401 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (and (and (and (and (and (and (<= (- 1) (+ (+ (+ x6 x9) (* x2 2)) x8)) (<= (+ (+ (+ (* x1 2) x0) x5) (- x7)) 0)) (<= (+ (+ (- x8) (* x5 2)) (- x7)) 1)) (<= (- 1) (synthTarget x6 x9 (* x8 2) (- x7) ))) (<= 0 (+ (+ (- x2) x1) (- x7)))) (<= (+ (synthTarget x0 x6 x5 x8 ) (- x7)) (- 1))) (<= 0 (+ (+ (+ (+ x9 x4) x6) (- x0)) x2))) (<= 1 (+ x8 x1))) (not (>= (+ (* x5 (- 2)) (+ (+ (* x8 4) (* x2 2)) (* x9 2))) (- 2))))))
(check-synth)
