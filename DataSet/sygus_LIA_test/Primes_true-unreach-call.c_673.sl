; Solution: 2 * var_4990471311850277980

(set-logic LIA)
(declare-var c_main_hashSymbolt~short13 Bool)

(declare-var c_main_hashSymbolt~ret12 Int)

(declare-var c_main_~f1~22 Int)

(declare-var c_main_~n~22 Int)

(synth-fun synthTarget((var_4990471311850277980 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_4990471311850277980 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_hashSymbolt~short13 (= c_main_hashSymbolt~ret12 c_main_~n~22)) (exists ((v_nnf_35 Int) (v_nnf_34 Int) )(and (<= (+ c_main_~f1~22 (synthTarget v_nnf_35 ) (synthTarget v_nnf_34 ) 1) c_main_hashSymbolt~ret12) (<= c_main_~f1~22 v_nnf_35) (<= v_nnf_35 v_nnf_34) (<= c_main_~n~22 2)))) (not (and (exists ((v_nnf_35 Int) (v_nnf_34 Int) )(and (<= (+ c_main_~f1~22 (synthTarget v_nnf_35 ) (synthTarget v_nnf_34 ) 1) c_main_hashSymbolt~ret12) (<= c_main_~f1~22 v_nnf_35) (<= v_nnf_35 v_nnf_34) (<= c_main_~n~22 2))) (<= c_main_~n~22 2))))))
(check-synth)
