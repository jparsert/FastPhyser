; Solution: 2 * var_10182303720247886543

(set-logic LIA)
(declare-var c_mult_hashSymbolin~n Int)

(declare-var c_mult_hashSymbolt~ret1 Int)

(declare-var c_mult_~n Int)

(synth-fun synthTarget((var_10182303720247886543 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_10182303720247886543 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (<= c_mult_hashSymbolin~n c_mult_~n) (exists ((v_nnf_29 Int) (v_nnf_28 Int) )(and (<= (+ (synthTarget v_nnf_29 ) (synthTarget v_nnf_28 ) 1) c_mult_hashSymbolt~ret1) (<= c_mult_~n v_nnf_29) (<= v_nnf_29 v_nnf_28) (<= c_mult_hashSymbolin~n c_mult_~n)))) (not (exists ((v_nnf_29 Int) (v_nnf_28 Int) )(and (<= (+ (synthTarget v_nnf_29 ) (synthTarget v_nnf_28 ) 1) c_mult_hashSymbolt~ret1) (<= c_mult_~n v_nnf_29) (<= v_nnf_29 v_nnf_28) (<= c_mult_hashSymbolin~n c_mult_~n)))))))
(check-synth)
