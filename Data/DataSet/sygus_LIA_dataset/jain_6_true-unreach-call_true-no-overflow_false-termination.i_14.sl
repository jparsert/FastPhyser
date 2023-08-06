; Solution: var_2687033163678452812 * var_8160707618087207196 + var_10036000938592315445

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

(synth-fun synthTarget((var_2687033163678452812 Int)(var_8160707618087207196 Int)(var_10036000938592315445 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_2687033163678452812 var_8160707618087207196 var_10036000938592315445 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_~y~0_primed (synthTarget 4 c_main_hashSymbolt~nondet1 c_main_~y~0 )) (= c_main_~z~0_primed (synthTarget 8 c_main_hashSymbolt~nondet2 c_main_~z~0 )) (= c_main_~x~0_primed (synthTarget 2 c_main_hashSymbolt~nondet0 c_main_~x~0 ))) (and (exists ((v_main_hashSymbolt~nondet2_5 Int) (v_main_hashSymbolt~nondet2_6 Int) )(= c_main_~z~0 (synthTarget 8 v_main_hashSymbolt~nondet2_5 (* 8 v_main_hashSymbolt~nondet2_6) ))) (exists ((v_main_hashSymbolt~nondet1_6 Int) (v_main_hashSymbolt~nondet1_5 Int) )(= (synthTarget 4 v_main_hashSymbolt~nondet1_6 (* 4 v_main_hashSymbolt~nondet1_5) ) c_main_~y~0)) (exists ((v_main_hashSymbolt~nondet0_5 Int) (v_main_hashSymbolt~nondet0_6 Int) )(= (synthTarget 2 v_main_hashSymbolt~nondet0_5 (* 2 v_main_hashSymbolt~nondet0_6) ) c_main_~x~0))) (not (and (exists ((v_main_hashSymbolt~nondet2_5 Int) (v_main_hashSymbolt~nondet2_6 Int) )(= c_main_~z~0_primed (synthTarget 8 v_main_hashSymbolt~nondet2_5 (* 8 v_main_hashSymbolt~nondet2_6) ))) (exists ((v_main_hashSymbolt~nondet1_6 Int) (v_main_hashSymbolt~nondet1_5 Int) )(= (synthTarget 4 v_main_hashSymbolt~nondet1_6 (* 4 v_main_hashSymbolt~nondet1_5) ) c_main_~y~0_primed)) (exists ((v_main_hashSymbolt~nondet0_5 Int) (v_main_hashSymbolt~nondet0_6 Int) )(= (synthTarget 2 v_main_hashSymbolt~nondet0_5 (* 2 v_main_hashSymbolt~nondet0_6) ) c_main_~x~0_primed)))))))
(check-synth)
