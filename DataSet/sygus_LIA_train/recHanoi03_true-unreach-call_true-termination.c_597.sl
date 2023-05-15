; Solution: 2 * var_7659616990813824842 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_7659616990813824842 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_7659616990813824842 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_35 Int) (v_nnf_36 Int) (v_nnf_34 Int) )(and (<= (synthTarget v_nnf_34 ) c_hanoi_hashSymbolt~ret0) (<= c_hanoi_~n 5) (<= 1 v_nnf_35) (<= (synthTarget v_nnf_35 ) v_nnf_36) (<= (synthTarget v_nnf_36 ) v_nnf_34) (<= c_hanoi_hashSymbolin~n c_hanoi_~n))) (not (and (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (exists ((v_nnf_39 Int) (v_nnf_37 Int) (v_nnf_38 Int) )(and (<= c_hanoi_hashSymbolin~n 5) (<= (synthTarget v_nnf_38 ) v_nnf_39) (<= (synthTarget v_nnf_39 ) c_hanoi_hashSymbolt~ret0) (<= (synthTarget v_nnf_37 ) v_nnf_38) (<= 1 v_nnf_37))))))))
(check-synth)
