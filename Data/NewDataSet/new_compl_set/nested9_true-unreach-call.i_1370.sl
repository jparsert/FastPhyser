; Solution: 2 * var_5929429518218019636 + 1

(set-logic LIA)
(declare-var c_main_~i~6 Int)

(declare-var c_main_~j~6 Int)

(declare-var c_main_~k~6 Int)

(synth-fun synthTarget((var_5929429518218019636 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_5929429518218019636 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (<= c_main_~j~6 (* 2 c_main_~i~6)) (<= c_main_~i~6 4) (exists ((v_nnf_78 Int) )(and (<= (+ v_nnf_78 2) c_main_~k~6) (<= c_main_~j~6 (synthTarget v_nnf_78 )) (<= v_nnf_78 4)))) (not (and (<= c_main_~j~6 (synthTarget c_main_~i~6 )) (<= c_main_~i~6 4) (<= c_main_~j~6 (* 2 c_main_~i~6)) (exists ((v_nnf_78 Int) )(and (<= (+ v_nnf_78 2) c_main_~k~6) (<= c_main_~j~6 (synthTarget v_nnf_78 )) (<= v_nnf_78 4))))))))
(check-synth)
