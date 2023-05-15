; Solution: 2 * var_2254878088804219376 + 1

(set-logic LIA)
(declare-var c_hanoi_hashSymbolin~n Int)

(declare-var c_hanoi_hashSymbolt~ret0 Int)

(declare-var c_hanoi_~n Int)

(synth-fun synthTarget((var_2254878088804219376 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_2254878088804219376 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (exists ((v_nnf_325 Int) )(and (<= (synthTarget v_nnf_325 ) c_hanoi_hashSymbolt~ret0) (<= c_hanoi_~n 3) (<= c_hanoi_hashSymbolin~n c_hanoi_~n) (<= 1 v_nnf_325))) (not (exists ((v_nnf_326 Int) )(and (<= c_hanoi_hashSymbolin~n 3) (<= (synthTarget v_nnf_326 ) c_hanoi_hashSymbolt~ret0) (<= 1 v_nnf_326)))))))
(check-synth)
