; Solution: 2 * var_13999183078839967701 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_13999183078839967701 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_13999183078839967701 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_236 Int) (v_nnf_235 Int) (v_nnf_234 Int) )(and (<= c_hanoi_~n 5) (<= (synthTarget v_nnf_235 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_236) (<= (synthTarget v_nnf_236 ) v_nnf_234) (<= (synthTarget v_nnf_234 ) v_nnf_235) (<= c_hanoi_hashSymbolin~n c_hanoi_~n))) (not (exists ((v_nnf_239 Int) (v_nnf_238 Int) (v_nnf_237 Int) )(and (<= c_hanoi_hashSymbolin~n 5) (<= (synthTarget v_nnf_239 ) v_nnf_238) (<= 1 v_nnf_237) (<= (synthTarget v_nnf_237 ) v_nnf_239) (<= (synthTarget v_nnf_238 ) c_hanoi_hashSymbolt~ret0)))))))
(check-synth)
