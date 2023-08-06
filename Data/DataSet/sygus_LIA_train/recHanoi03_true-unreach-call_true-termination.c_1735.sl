; Solution: 2 * var_13709301693579166951 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_13709301693579166951 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_13709301693579166951 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_148 Int) )(and (<= c_hanoi_~n 3) (<= (synthTarget v_nnf_148 ) c_hanoi_hashSymbolt~ret0) (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (<= 1 v_nnf_148))) (not (exists ((v_nnf_149 Int) )(and (<= c_hanoi_hashSymbolin~n 3) (<= (synthTarget v_nnf_149 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_149)))))))
(check-synth)
