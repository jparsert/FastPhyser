; smt-lib-version 2.6
; source 
;  Christoph Erkinger, "Rotating Workforce Scheduling as Satisfiability Modulo
;  Theories", Master's Thesis, Technische Universitaet Wien, 2013
;
; category industrial
; status sat
; Solution: var_8017161083327690121 + var_18033362336530588742 + var_5351194882203080099 + var_14720483704953079368 + var_6363174845723628059 + var_2612485781184938690 + var_1461932766450684049 + var_16162422890247776222 + var_8740608214485245048

(set-logic LIA)
(synth-fun synthTarget((var_8017161083327690121 Int)(var_18033362336530588742 Int)(var_5351194882203080099 Int)(var_14720483704953079368 Int)(var_6363174845723628059 Int)(var_2612485781184938690 Int)(var_1461932766450684049 Int)(var_16162422890247776222 Int)(var_8740608214485245048 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_8017161083327690121 var_18033362336530588742 var_5351194882203080099 var_14720483704953079368 var_6363174845723628059 var_2612485781184938690 var_1461932766450684049 var_16162422890247776222 var_8740608214485245048 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (synthTarget 0 10 91 10 1 0 91 1 0 ) 204))
(constraint (= (synthTarget 10 0 0 91 10 1 0 91 1 ) 204))
(constraint (= (synthTarget 10 0 0 91 91 10 1 0 1 ) 204))
(constraint (= (synthTarget 91 0 10 0 91 10 1 0 1 ) 204))
(constraint (= (synthTarget 91 1 10 0 91 10 1 0 10 ) 214))
(constraint (= (synthTarget 91 1 10 1 0 91 10 0 10 ) 214))
(constraint (= (synthTarget 91 10 10 1 0 91 10 1 0 ) 214))
(check-synth)
