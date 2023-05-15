; Solution: 2 * var_1531303539703608119 + 1

(set-logic LIA)
(declare-var c_main_~i~6 Int)

(declare-var c_main_~j~6 Int)

(declare-var c_main_~k~6 Int)

(synth-fun synthTarget((var_1531303539703608119 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_1531303539703608119 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (<= c_main_~j~6 (* 2 c_main_~i~6)) (<= c_main_~i~6 3) (<= c_main_~i~6 1) (<= c_main_~i~6 2) (exists ((v_nnf_30 Int) )(and (<= (+ v_nnf_30 1) c_main_~k~6) (<= v_nnf_30 3) (<= c_main_~j~6 (synthTarget v_nnf_30 ))))) (not (and (<= c_main_~j~6 (* 2 c_main_~i~6)) (<= c_main_~i~6 3) (<= c_main_~j~6 (synthTarget c_main_~i~6 )) (<= c_main_~i~6 2) (exists ((v_nnf_30 Int) )(and (<= (+ v_nnf_30 1) c_main_~k~6) (<= v_nnf_30 3) (<= c_main_~j~6 (synthTarget v_nnf_30 )))))))))
(check-synth)
