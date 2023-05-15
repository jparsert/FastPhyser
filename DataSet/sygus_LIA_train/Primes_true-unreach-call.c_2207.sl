; Solution: 2 * var_4055868542503230027 + 2 * var_3335244665244012646 + 1

(set-logic LIA)
(declare-var c_mult_hashSymbolin~n Int)

(declare-var c_mult_hashSymbolres Int)

(declare-var c_mult_~n Int)

(synth-fun synthTarget((var_4055868542503230027 Int)(var_3335244665244012646 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_4055868542503230027 var_3335244665244012646 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_107 Int) )(and (<= (synthTarget c_mult_~n v_nnf_107 ) c_mult_hashSymbolres) (<= c_mult_~n v_nnf_107) (<= c_mult_hashSymbolin~n c_mult_~n))) (not (and (<= c_mult_hashSymbolin~n c_mult_~n) (exists ((mult_~n Int) (v_nnf_108 Int) )(and (<= (synthTarget mult_~n v_nnf_108 ) c_mult_hashSymbolres) (<= c_mult_hashSymbolin~n mult_~n) (<= mult_~n v_nnf_108))))))))
(check-synth)
