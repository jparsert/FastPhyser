; Solution: var_7008388960703628778 + var_8521823971041207751 * -2

(set-logic LIA)
(declare-var x3 Int)

(declare-var x4 Int)

(declare-var x7 Int)

(declare-var x8 Int)

(synth-fun synthTarget((var_7008388960703628778 Int)(var_8521823971041207751 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_7008388960703628778 var_8521823971041207751 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (not (>= (+ (* x4 2) (synthTarget (* x7 (- 2)) x8 )) 2)) (and (and (not (<= 1 x4)) (<= (+ (synthTarget (+ (- x3) x8) x4 ) x7) (- 1))) (<= (+ (+ x3 x8) x7) 0)))))
(check-synth)
