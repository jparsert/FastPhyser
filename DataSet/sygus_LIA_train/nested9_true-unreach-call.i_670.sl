; Solution: 2 * var_16451057996150921605 + 1

(set-logic LIA)
(declare-var c_main_~i~6 Int)

(declare-var c_main_~j~6 Int)

(declare-var c_main_~k~6 Int)

(synth-fun synthTarget((var_16451057996150921605 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_16451057996150921605 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (<= c_main_~k~6 c_main_~i~6) (<= (synthTarget c_main_~i~6 ) c_main_~j~6) (<= 3 c_main_~i~6)) (not (and (<= 3 c_main_~i~6) (<= 2 c_main_~i~6) (<= 1 c_main_~i~6) (<= 0 c_main_~i~6) (<= (* 2 c_main_~i~6) c_main_~j~6) (exists ((v_nnf_40 Int) )(and (<= c_main_~k~6 (+ v_nnf_40 2)) (<= (synthTarget v_nnf_40 ) c_main_~j~6) (<= 3 v_nnf_40))))))))
(check-synth)
