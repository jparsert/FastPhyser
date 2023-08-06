; Solution: 2 * var_5567948210597090811 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_5567948210597090811 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_5567948210597090811 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_51 Int) )(and (<= c_hanoi_~n 3) (<= (synthTarget v_nnf_51 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_51) (<= c_hanoi_hashSymbolin~n c_hanoi_~n))) (not (and (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (exists ((v_nnf_52 Int) )(and (<= c_hanoi_hashSymbolin~n 3) (<= 1 v_nnf_52) (<= (synthTarget v_nnf_52 ) c_hanoi_hashSymbolt~ret0))))))))
(check-synth)
