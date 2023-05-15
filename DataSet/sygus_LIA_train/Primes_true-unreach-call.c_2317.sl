; Solution: var_9747394547796566215 + 2 * var_11550342337053005580 + var_2253174426395290987 + 1

(set-logic LIA)
(declare-var c_mult_hashSymbolin~n Int)

(declare-var c_mult_hashSymbolres Int)

(declare-var c_mult_~n Int)

(synth-fun synthTarget((var_9747394547796566215 Int)(var_11550342337053005580 Int)(var_2253174426395290987 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_9747394547796566215 var_11550342337053005580 var_2253174426395290987 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_111 Int) (v_nnf_112 Int) )(and (<= (synthTarget c_mult_~n v_nnf_111 (* 2 v_nnf_112) ) c_mult_hashSymbolres) (<= c_mult_~n v_nnf_111) (<= v_nnf_111 v_nnf_112) (<= c_mult_hashSymbolin~n c_mult_~n))) (not (and (<= c_mult_hashSymbolin~n c_mult_~n) (exists ((v_nnf_114 Int) (v_nnf_113 Int) )(and (<= c_mult_hashSymbolin~n v_nnf_113) (<= (synthTarget (* 2 v_nnf_114) v_nnf_113 c_mult_hashSymbolin~n ) c_mult_hashSymbolres) (<= v_nnf_113 v_nnf_114))))))))
(check-synth)
