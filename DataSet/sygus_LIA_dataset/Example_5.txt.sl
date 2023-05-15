; smt-lib-version 2.6
; source 
;  Christoph Erkinger, "Rotating Workforce Scheduling as Satisfiability Modulo
;  Theories", Master's Thesis, Technische Universitaet Wien, 2013
;
; category industrial
; status sat
; Solution: var_6071497836930504987 + var_8520858473283673276 + var_10253648811068180671 + var_2396385432833966655 + var_11623235112554050052 + var_7585240305148724351 + var_15802631262947345078 + var_3550066801509970901 + var_164276559652265396 + var_6579615931269929111 + var_17528714186322441695

(set-logic LIA)
(synth-fun synthTarget((var_6071497836930504987 Int)(var_8520858473283673276 Int)(var_10253648811068180671 Int)(var_2396385432833966655 Int)(var_11623235112554050052 Int)(var_7585240305148724351 Int)(var_15802631262947345078 Int)(var_3550066801509970901 Int)(var_164276559652265396 Int)(var_6579615931269929111 Int)(var_17528714186322441695 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_6071497836930504987 var_8520858473283673276 var_10253648811068180671 var_2396385432833966655 var_11623235112554050052 var_7585240305148724351 var_15802631262947345078 var_3550066801509970901 var_164276559652265396 var_6579615931269929111 var_17528714186322441695 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (synthTarget 0 0 0 0 0 0 0 133 133 133 0 ) 399))
(constraint (= (synthTarget 1 1 12 0 12 1 12 0 133 133 133 ) 438))
(constraint (= (synthTarget 1 1 12 133 12 1 12 0 0 133 133 ) 438))
(constraint (= (synthTarget 1 12 0 0 0 12 0 1 12 1 0 ) 39))
(constraint (= (synthTarget 1 12 0 133 133 12 133 1 12 1 0 ) 438))
(constraint (= (synthTarget 1 12 12 133 133 1 12 1 0 0 133 ) 438))
(constraint (= (synthTarget 1 12 12 133 133 1 133 1 12 0 0 ) 438))
(check-synth)
