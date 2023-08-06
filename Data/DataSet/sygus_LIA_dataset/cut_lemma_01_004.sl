; Solution: (((((-var_12557062569220834368 + var_12196652776214519977) + var_18034818085020564500) + var_9170324193189505692) + var_12198497487422889285) + var_14432484883539542301) + var_7731874287397029900

(set-logic LIA)
(declare-var x0 Int)

(declare-var x1 Int)

(declare-var x10 Int)

(declare-var x11 Int)

(declare-var x12 Int)

(declare-var x13 Int)

(declare-var x14 Int)

(declare-var x2 Int)

(declare-var x3 Int)

(declare-var x4 Int)

(declare-var x5 Int)

(declare-var x6 Int)

(declare-var x7 Int)

(declare-var x8 Int)

(declare-var x9 Int)

(synth-fun synthTarget((var_12557062569220834368 Int)(var_12196652776214519977 Int)(var_18034818085020564500 Int)(var_9170324193189505692 Int)(var_12198497487422889285 Int)(var_14432484883539542301 Int)(var_7731874287397029900 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_12557062569220834368 var_12196652776214519977 var_18034818085020564500 var_9170324193189505692 var_12198497487422889285 var_14432484883539542301 var_7731874287397029900 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (not (>= (+ (* x1 (- 48675)) (+ (* x5 48675) (+ (* x9 (- 17700)) (+ (* x2 (- 27789)) (+ (* x0 17700) (+ (* x13 (- 244083)) (+ (* x6 (- 17700)) (+ (+ (* x10 (- 48675)) (+ (* x11 87261) (+ (* x4 48675) (+ (* x14 (- 146025)) (* x3 97350))))) (* x8 38586))))))))) 97350)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 1 (+ (+ (+ (+ (+ (* x10 2) x2) x0) (- x4)) (- x13)) (- x6))) (<= (+ (+ (+ (+ (+ (+ x8 x10) (- x11)) (- x4)) x14) (- x3)) (- x7)) (- 1))) (<= (synthTarget x0 x2 x12 (- x11) x6 (- x3) (* x7 3) ) 0)) (<= 1 (+ (+ (+ (+ (- x2) x1) (- x4)) (* x13 (- 3))) x5))) (<= (synthTarget x2 x10 (- x11) (- x4) (- x13) x14 x3 ) (- 1))) (<= (+ (+ (+ (+ (* x1 2) x8) (- x11)) (- x4)) (- x3)) 0)) (<= 0 (+ (+ (+ (+ (- x0) x2) (- x13)) x6) x9))) (<= 0 (+ (+ (+ (+ (+ (* x0 (- 2)) x2) (* x8 (- 2))) x5) (- x9)) (- x7)))) (<= 0 (+ (+ (+ x8 x2) x11) (* x13 (- 3))))) (<= (+ (+ (+ (+ (* x2 2) x10) x0) x14) (- x7)) (- 1))) (<= (- 1) (+ (+ (+ (+ (- x11) x8) (* x5 2)) (- x9)) x3))) (<= (synthTarget x8 x1 (- x12) x11 (* x13 2) (* x5 2) (- x7) ) 1)) (<= (- 1) (+ (+ (+ (+ (+ (+ (+ x10 x1) (- x0)) (- x6)) x14) (- x5)) (* x9 (- 2))) (- x3)))) (<= 0 (+ (+ (+ (- x2) x1) x0) (* x14 (- 2))))) (<= (synthTarget x8 x1 x12 (- x11) x4 (- x13) (- x14) ) 0)))))
(check-synth)
