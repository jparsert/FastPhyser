; Solution: 2 * var_11623490804528312435 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_11623490804528312435 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_11623490804528312435 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_151 Int) (v_nnf_152 Int) )(and (<= c_hanoi_~n 4) (<= (synthTarget v_nnf_151 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_152) (<= (synthTarget v_nnf_152 ) v_nnf_151) (<= c_hanoi_hashSymbolin~n c_hanoi_~n))) (not (exists ((v_nnf_154 Int) (v_nnf_153 Int) )(and (<= c_hanoi_hashSymbolin~n 4) (<= 1 v_nnf_154) (<= (synthTarget v_nnf_153 ) c_hanoi_hashSymbolt~ret0) (<= (synthTarget v_nnf_154 ) v_nnf_153)))))))
(check-synth)
