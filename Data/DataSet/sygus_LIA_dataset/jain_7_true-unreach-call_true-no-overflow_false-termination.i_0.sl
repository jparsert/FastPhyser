; Solution: var_6722482180027076693 * var_597063067215761875 + var_8450992114408453037

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

(synth-fun synthTarget((var_6722482180027076693 Int)(var_597063067215761875 Int)(var_8450992114408453037 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_6722482180027076693 var_597063067215761875 var_8450992114408453037 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_~z~0_primed (synthTarget 4194304 c_main_hashSymbolt~nondet2 c_main_~z~0 )) (= c_main_~x~0_primed (synthTarget 1048576 c_main_hashSymbolt~nondet0 c_main_~x~0 )) (= c_main_~y~0_primed (synthTarget 2097152 c_main_hashSymbolt~nondet1 c_main_~y~0 ))) (and (exists ((v_main_hashSymbolt~nondet0_3 Int) )(= (* 1048576 v_main_hashSymbolt~nondet0_3) c_main_~x~0)) (exists ((v_main_hashSymbolt~nondet1_3 Int) )(= c_main_~y~0 (* 2097152 v_main_hashSymbolt~nondet1_3))) (exists ((v_main_hashSymbolt~nondet2_3 Int) )(= (* 4194304 v_main_hashSymbolt~nondet2_3) c_main_~z~0))) (not (and (exists ((v_main_hashSymbolt~nondet0_3 Int) )(= (* 1048576 v_main_hashSymbolt~nondet0_3) c_main_~x~0_primed)) (exists ((v_main_hashSymbolt~nondet1_3 Int) )(= c_main_~y~0_primed (* 2097152 v_main_hashSymbolt~nondet1_3))) (exists ((v_main_hashSymbolt~nondet2_3 Int) )(= (* 4194304 v_main_hashSymbolt~nondet2_3) c_main_~z~0_primed)))))))
(check-synth)
