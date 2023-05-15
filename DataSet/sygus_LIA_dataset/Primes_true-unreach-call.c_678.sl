; Solution: 2 * var_14576494377114930658

(set-logic LIA)
(declare-var main_hashSymbolt~short13_1 Bool)

(declare-var main_hashSymbolt~ret12_0 Int)

(declare-var main_~f1~22_0 Int)

(declare-var main_~n~22_0 Int)

(synth-fun synthTarget((var_14576494377114930658 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_14576494377114930658 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (exists ((v_nnf_35 Int) (v_nnf_34 Int) )(and (<= (+ main_~f1~22_0 (synthTarget v_nnf_35 ) (synthTarget v_nnf_34 ) 1) main_hashSymbolt~ret12_0) (<= main_~f1~22_0 v_nnf_35) (<= v_nnf_35 v_nnf_34) (<= main_~n~22_0 2))) (<= main_~n~22_0 2)) (= main_hashSymbolt~short13_1 (= main_hashSymbolt~ret12_0 main_~n~22_0)) (not (exists ((v_nnf_35 Int) (v_nnf_34 Int) )(and (<= (+ main_~f1~22_0 (synthTarget v_nnf_35 ) (synthTarget v_nnf_34 ) 1) main_hashSymbolt~ret12_0) (<= main_~f1~22_0 v_nnf_35) (<= v_nnf_35 v_nnf_34) (<= main_~n~22_0 2)))))))
(check-synth)
