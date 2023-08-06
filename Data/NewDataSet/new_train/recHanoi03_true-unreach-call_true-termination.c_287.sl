; Solution: 2 * var_16665924139294496435 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolres Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_16665924139294496435 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_16665924139294496435 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (exists ((v_hanoi_hashSymbolt~ret0_10 Int) (v_nnf_18 Int) (v_nnf_17 Int) )(and (<= (synthTarget v_hanoi_hashSymbolt~ret0_10 ) c_hanoi_hashSymbolres) (<= c_hanoi_hashSymbolin~n 4) (<= 1 v_nnf_17) (<= (synthTarget v_nnf_17 ) v_nnf_18) (<= (synthTarget v_nnf_18 ) v_hanoi_hashSymbolt~ret0_10)))) (not (exists ((v_hanoi_hashSymbolt~ret0_10 Int) (v_nnf_18 Int) (v_nnf_17 Int) )(and (<= (synthTarget v_hanoi_hashSymbolt~ret0_10 ) c_hanoi_hashSymbolres) (<= c_hanoi_hashSymbolin~n 4) (<= 1 v_nnf_17) (<= (synthTarget v_nnf_17 ) v_nnf_18) (<= (synthTarget v_nnf_18 ) v_hanoi_hashSymbolt~ret0_10)))))))
(check-synth)
