; Solution: 2 * var_10612339171743140656 + var_4486419008017313015

(set-logic LIA)
(declare-var c_main_hashSymbolt~nondet0 Int)

(declare-var c_main_hashSymbolt~nondet1 Int)

(declare-var c_main_~x~0 Int)

(declare-var c_main_~x~0_primed Int)

(declare-var c_main_~y~0 Int)

(declare-var c_main_~y~0_primed Int)

(synth-fun synthTarget((var_10612339171743140656 Int)(var_4486419008017313015 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_10612339171743140656 var_4486419008017313015 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (= c_main_~y~0_primed (synthTarget c_main_hashSymbolt~nondet1 c_main_~y~0 )) (= c_main_~x~0_primed (synthTarget c_main_hashSymbolt~nondet0 c_main_~x~0 ))) (and (exists ((v_main_hashSymbolt~nondet0_3 Int) )(= (synthTarget v_main_hashSymbolt~nondet0_3 1 ) c_main_~x~0)) (exists ((v_main_hashSymbolt~nondet1_3 Int) )(= c_main_~y~0 (synthTarget v_main_hashSymbolt~nondet1_3 1 )))) (not (and (exists ((v_main_hashSymbolt~nondet0_3 Int) )(= (synthTarget v_main_hashSymbolt~nondet0_3 1 ) c_main_~x~0_primed)) (exists ((v_main_hashSymbolt~nondet1_3 Int) )(= c_main_~y~0_primed (synthTarget v_main_hashSymbolt~nondet1_3 1 ))))))))
(check-synth)
