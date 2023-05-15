; Solution: 2 * var_12199365612832978704 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolres Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_12199365612832978704 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_12199365612832978704 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (exists ((v_hanoi_hashSymbolt~ret0_13 Int) (v_nnf_32 Int) (v_nnf_33 Int) )(and (<= c_hanoi_hashSymbolin~n 4) (<= 1 v_nnf_32) (<= (synthTarget v_nnf_32 ) v_nnf_33) (<= (synthTarget v_nnf_33 ) v_hanoi_hashSymbolt~ret0_13) (<= (synthTarget v_hanoi_hashSymbolt~ret0_13 ) c_hanoi_hashSymbolres))) (<= c_hanoi_hashSymbolin~n c_hanoi_~n)) (not (exists ((v_hanoi_hashSymbolt~ret0_13 Int) (v_nnf_32 Int) (v_nnf_33 Int) )(and (<= c_hanoi_hashSymbolin~n 4) (<= 1 v_nnf_32) (<= (synthTarget v_nnf_32 ) v_nnf_33) (<= (synthTarget v_nnf_33 ) v_hanoi_hashSymbolt~ret0_13) (<= (synthTarget v_hanoi_hashSymbolt~ret0_13 ) c_hanoi_hashSymbolres)))))))
(check-synth)
