; Solution: var_13927818228090053938 * var_1532684384428209461 + var_9100455344691026243

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

(synth-fun synthTarget((var_13927818228090053938 Int)(var_1532684384428209461 Int)(var_9100455344691026243 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_13927818228090053938 var_1532684384428209461 var_9100455344691026243 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_~y~0_primed (synthTarget 4 c_main_hashSymbolt~nondet1 c_main_~y~0 )) (= c_main_~z~0_primed (synthTarget 8 c_main_hashSymbolt~nondet2 c_main_~z~0 )) (= c_main_~x~0_primed (synthTarget 2 c_main_hashSymbolt~nondet0 c_main_~x~0 ))) (and (exists ((v_main_hashSymbolt~nondet2_5 Int) (v_main_hashSymbolt~nondet2_6 Int) )(= c_main_~z~0 (synthTarget 8 v_main_hashSymbolt~nondet2_5 (* 8 v_main_hashSymbolt~nondet2_6) ))) (exists ((v_main_hashSymbolt~nondet1_6 Int) (v_main_hashSymbolt~nondet1_5 Int) )(= (synthTarget 4 v_main_hashSymbolt~nondet1_6 (* 4 v_main_hashSymbolt~nondet1_5) ) c_main_~y~0)) (exists ((v_main_hashSymbolt~nondet0_5 Int) (v_main_hashSymbolt~nondet0_6 Int) )(= (synthTarget 2 v_main_hashSymbolt~nondet0_5 (* 2 v_main_hashSymbolt~nondet0_6) ) c_main_~x~0))) (not (and (exists ((v_main_hashSymbolt~nondet1_5 Int) )(= (* 4 v_main_hashSymbolt~nondet1_5) c_main_~y~0_primed)) (exists ((v_main_hashSymbolt~nondet0_5 Int) )(= (* 2 v_main_hashSymbolt~nondet0_5) c_main_~x~0_primed)) (exists ((v_main_hashSymbolt~nondet2_5 Int) )(= (* 8 v_main_hashSymbolt~nondet2_5) c_main_~z~0_primed)))))))
(check-synth)
