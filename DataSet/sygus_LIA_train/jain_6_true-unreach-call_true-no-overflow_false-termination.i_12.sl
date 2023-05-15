; Solution: var_2686646441321956570 * var_17313436384429398288 + var_13926911889754508934

(set-logic LIA)
(declare-var c_main_hashSymbolt~nondet0 Int)

(declare-var c_main_hashSymbolt~nondet1 Int)

(declare-var c_main_hashSymbolt~nondet2 Int)

(declare-var c_main_~x~0 Int)

(declare-var c_main_~x~0_primed Int)

(declare-var c_main_~y~0 Int)

(declare-var c_main_~y~0_primed Int)

(declare-var c_main_~z~0 Int)

(declare-var c_main_~z~0_primed Int)

(synth-fun synthTarget((var_2686646441321956570 Int)(var_17313436384429398288 Int)(var_13926911889754508934 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_2686646441321956570 var_17313436384429398288 var_13926911889754508934 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_~y~0_primed (synthTarget 4 c_main_hashSymbolt~nondet1 c_main_~y~0 )) (= c_main_~z~0_primed (synthTarget 8 c_main_hashSymbolt~nondet2 c_main_~z~0 )) (= c_main_~x~0_primed (synthTarget 2 c_main_hashSymbolt~nondet0 c_main_~x~0 ))) (and (exists ((v_main_hashSymbolt~nondet1_5 Int) )(= (* 4 v_main_hashSymbolt~nondet1_5) c_main_~y~0)) (exists ((v_main_hashSymbolt~nondet0_5 Int) )(= (* 2 v_main_hashSymbolt~nondet0_5) c_main_~x~0)) (exists ((v_main_hashSymbolt~nondet2_5 Int) )(= (* 8 v_main_hashSymbolt~nondet2_5) c_main_~z~0))) (not (and (exists ((v_main_hashSymbolt~nondet1_5 Int) )(= (* 4 v_main_hashSymbolt~nondet1_5) c_main_~y~0_primed)) (exists ((v_main_hashSymbolt~nondet0_5 Int) )(= (* 2 v_main_hashSymbolt~nondet0_5) c_main_~x~0_primed)) (exists ((v_main_hashSymbolt~nondet2_5 Int) )(= (* 8 v_main_hashSymbolt~nondet2_5) c_main_~z~0_primed)))))))
(check-synth)
