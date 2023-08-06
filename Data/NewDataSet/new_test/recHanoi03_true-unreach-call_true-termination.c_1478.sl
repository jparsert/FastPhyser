; Solution: 2 * var_8665204878818546152 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_8665204878818546152 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_8665204878818546152 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_94 Int) (v_nnf_95 Int) )(and (<= c_hanoi_~n 4) (<= (synthTarget v_nnf_94 ) c_hanoi_hashSymbolt~ret0) (<= (synthTarget v_nnf_95 ) v_nnf_94) (<= 1 v_nnf_95) (<= c_hanoi_hashSymbolin~n c_hanoi_~n))) (not (and (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (exists ((v_nnf_97 Int) (v_nnf_96 Int) )(and (<= c_hanoi_hashSymbolin~n 4) (<= (synthTarget v_nnf_96 ) c_hanoi_hashSymbolt~ret0) (<= (synthTarget v_nnf_97 ) v_nnf_96) (<= 1 v_nnf_97))))))))
(check-synth)
