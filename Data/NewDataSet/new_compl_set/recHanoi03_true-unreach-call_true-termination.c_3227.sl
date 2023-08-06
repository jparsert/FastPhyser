; Solution: 2 * var_2254852946401912675 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolres Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_2254852946401912675 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_2254852946401912675 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (exists ((v_nnf_227 Int) (v_hanoi_hashSymbolt~ret0_34 Int) )(and (<= (synthTarget v_hanoi_hashSymbolt~ret0_34 ) c_hanoi_hashSymbolres) (<= 1 v_nnf_227) (<= (synthTarget v_nnf_227 ) v_hanoi_hashSymbolt~ret0_34) (<= c_hanoi_hashSymbolin~n 3))) (<= c_hanoi_hashSymbolin~n c_hanoi_~n)) (not (exists ((v_nnf_227 Int) (v_hanoi_hashSymbolt~ret0_34 Int) )(and (<= (synthTarget v_hanoi_hashSymbolt~ret0_34 ) c_hanoi_hashSymbolres) (<= 1 v_nnf_227) (<= (synthTarget v_nnf_227 ) v_hanoi_hashSymbolt~ret0_34) (<= c_hanoi_hashSymbolin~n 3)))))))
(check-synth)
