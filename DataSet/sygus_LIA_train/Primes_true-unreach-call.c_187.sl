; Solution: 2 * var_6863743126540762518

(set-logic LIA)
(declare-var c_main_hashSymbolt~short13 Bool)

(declare-var c_main_hashSymbolt~ret12 Int)

(declare-var c_main_~f1~22 Int)

(declare-var c_main_~n~22 Int)

(synth-fun synthTarget((var_6863743126540762518 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_6863743126540762518 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_hashSymbolt~short13 (= c_main_hashSymbolt~ret12 c_main_~n~22)) (exists ((v_nnf_16 Int) (v_nnf_17 Int) )(and (<= (+ (synthTarget v_nnf_16 ) (synthTarget v_nnf_17 ) 1) c_main_hashSymbolt~ret12) (<= c_main_~f1~22 v_nnf_16) (<= c_main_~n~22 2) (<= v_nnf_16 v_nnf_17)))) (not (exists ((v_nnf_16 Int) (v_nnf_17 Int) )(and (<= (+ (synthTarget v_nnf_16 ) (synthTarget v_nnf_17 ) 1) c_main_hashSymbolt~ret12) (<= c_main_~f1~22 v_nnf_16) (<= c_main_~n~22 2) (<= v_nnf_16 v_nnf_17)))))))
(check-synth)
