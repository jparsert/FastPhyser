; Solution: 2 * var_15081119806902471843 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_15081119806902471843 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_15081119806902471843 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_14 Int) (v_nnf_13 Int) )(and (<= c_hanoi_~n 4) (<= (synthTarget v_nnf_14 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_13) (<= (synthTarget v_nnf_13 ) v_nnf_14) (<= c_hanoi_hashSymbolin~n c_hanoi_~n))) (not (and (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (exists ((v_nnf_16 Int) (v_nnf_15 Int) )(and (<= c_hanoi_hashSymbolin~n 4) (<= (synthTarget v_nnf_16 ) v_nnf_15) (<= 1 v_nnf_16) (<= (synthTarget v_nnf_15 ) c_hanoi_hashSymbolt~ret0))))))))
(check-synth)
