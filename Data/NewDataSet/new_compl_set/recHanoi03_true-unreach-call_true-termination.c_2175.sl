; Solution: 2 * var_17962635094729674043 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolres Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_17962635094729674043 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_17962635094729674043 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (exists ((v_hanoi_hashSymbolt~ret0_27 Int) (v_nnf_150 Int) )(and (<= 1 v_nnf_150) (<= (synthTarget v_nnf_150 ) v_hanoi_hashSymbolt~ret0_27) (<= c_hanoi_hashSymbolin~n 3) (<= (synthTarget v_hanoi_hashSymbolt~ret0_27 ) c_hanoi_hashSymbolres))) (<= c_hanoi_hashSymbolin~n c_hanoi_~n)) (not (exists ((v_hanoi_hashSymbolt~ret0_27 Int) (v_nnf_150 Int) )(and (<= 1 v_nnf_150) (<= (synthTarget v_nnf_150 ) v_hanoi_hashSymbolt~ret0_27) (<= c_hanoi_hashSymbolin~n 3) (<= (synthTarget v_hanoi_hashSymbolt~ret0_27 ) c_hanoi_hashSymbolres)))))))
(check-synth)
