; Solution: 2 * var_12846845272245727816 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_12846845272245727816 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_12846845272245727816 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_229 Int) (v_nnf_228 Int) )(and (<= c_hanoi_~n 4) (<= (synthTarget v_nnf_229 ) c_hanoi_hashSymbolt~ret0) (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (<= 1 v_nnf_228) (<= (synthTarget v_nnf_228 ) v_nnf_229))) (not (exists ((v_nnf_231 Int) (v_nnf_230 Int) )(and (<= c_hanoi_hashSymbolin~n 4) (<= (synthTarget v_nnf_231 ) v_nnf_230) (<= (synthTarget v_nnf_230 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_231)))))))
(check-synth)
