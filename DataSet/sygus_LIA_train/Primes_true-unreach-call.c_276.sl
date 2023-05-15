; Solution: 2 * var_811725384105418605 + 2 * var_742001407266728310 + 1

(set-logic LIA)
(declare-var c_mult_hashSymbolin~n Int)

(declare-var c_mult_hashSymbolres Int)

(declare-var c_mult_~n Int)

(synth-fun synthTarget((var_811725384105418605 Int)(var_742001407266728310 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_811725384105418605 var_742001407266728310 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_14 Int) )(and (<= (synthTarget v_nnf_14 c_mult_~n ) c_mult_hashSymbolres) (<= c_mult_hashSymbolin~n c_mult_~n) (<= c_mult_~n v_nnf_14))) (not (and (<= c_mult_hashSymbolin~n c_mult_~n) (exists ((mult_~n Int) (v_nnf_15 Int) )(and (<= (synthTarget mult_~n v_nnf_15 ) c_mult_hashSymbolres) (<= c_mult_hashSymbolin~n mult_~n) (<= mult_~n v_nnf_15))))))))
(check-synth)
