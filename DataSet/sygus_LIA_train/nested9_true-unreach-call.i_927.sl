; Solution: 2 * var_5642611631177776988 + var_162669777608184528

(set-logic LIA)
(declare-var c_main_~i~6 Int)

(declare-var c_main_~j~6 Int)

(declare-var c_main_~k~6 Int)

(synth-fun synthTarget((var_5642611631177776988 Int)(var_162669777608184528 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_5642611631177776988 var_162669777608184528 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (<= c_main_~k~6 c_main_~i~6) (<= (synthTarget c_main_~i~6 2 ) c_main_~j~6) (<= 3 c_main_~i~6)) (not (and (<= 3 c_main_~i~6) (<= (synthTarget c_main_~i~6 1 ) c_main_~j~6) (<= 2 c_main_~i~6) (<= (* 2 c_main_~i~6) c_main_~j~6) (exists ((v_nnf_54 Int) )(and (<= c_main_~k~6 (+ v_nnf_54 1)) (<= 3 v_nnf_54) (<= (synthTarget v_nnf_54 2 ) c_main_~j~6))) (<= 0 c_main_~i~6) (<= 1 c_main_~i~6))))))
(check-synth)
