; Solution: 2 * var_6362027130349576632

(set-logic LIA)
(declare-var c_main_hashSymbolt~short13 Bool)

(declare-var c_main_hashSymbolt~ret12 Int)

(declare-var c_main_~f1~22 Int)

(declare-var c_main_~n~22 Int)

(synth-fun synthTarget((var_6362027130349576632 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_6362027130349576632 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_hashSymbolt~short13 (= c_main_hashSymbolt~ret12 c_main_~n~22)) (exists ((v_nnf_60 Int) (v_nnf_58 Int) (v_nnf_59 Int) )(and (<= (+ (synthTarget v_nnf_60 ) (synthTarget v_nnf_58 ) (synthTarget v_nnf_59 ) 1) c_main_hashSymbolt~ret12) (<= c_main_~f1~22 v_nnf_58) (<= v_nnf_58 v_nnf_60) (<= v_nnf_60 v_nnf_59) (<= c_main_~n~22 2)))) (not (exists ((v_nnf_60 Int) (v_nnf_58 Int) (v_nnf_59 Int) )(and (<= (+ (synthTarget v_nnf_60 ) (synthTarget v_nnf_58 ) (synthTarget v_nnf_59 ) 1) c_main_hashSymbolt~ret12) (<= c_main_~f1~22 v_nnf_58) (<= v_nnf_58 v_nnf_60) (<= v_nnf_60 v_nnf_59) (<= c_main_~n~22 2)))))))
(check-synth)
