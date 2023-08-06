; Solution: var_6723859335928628031 + 2 * var_3840790843639240356 + var_8741437596387977568 + 1

(set-logic LIA)
(declare-var c_mult_hashSymbolin~n Int)

(declare-var c_mult_hashSymbolres Int)

(declare-var c_mult_~n Int)

(synth-fun synthTarget((var_6723859335928628031 Int)(var_3840790843639240356 Int)(var_8741437596387977568 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_6723859335928628031 var_3840790843639240356 var_8741437596387977568 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_31 Int) (v_nnf_30 Int) )(and (<= (synthTarget c_mult_~n v_nnf_31 (* 2 v_nnf_30) ) c_mult_hashSymbolres) (<= c_mult_~n v_nnf_30) (<= v_nnf_30 v_nnf_31) (<= c_mult_hashSymbolin~n c_mult_~n))) (not (and (<= c_mult_hashSymbolin~n c_mult_~n) (exists ((v_nnf_32 Int) (v_nnf_33 Int) )(and (<= c_mult_hashSymbolin~n v_nnf_33) (<= (synthTarget (* 2 v_nnf_32) v_nnf_33 c_mult_hashSymbolin~n ) c_mult_hashSymbolres) (<= v_nnf_33 v_nnf_32))))))))
(check-synth)
