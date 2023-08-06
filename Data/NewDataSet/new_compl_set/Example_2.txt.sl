; smt-lib-version 2.6
; source 
;  Christoph Erkinger, "Rotating Workforce Scheduling as Satisfiability Modulo
;  Theories", Master's Thesis, Technische Universitaet Wien, 2013
;
; category industrial
; status sat
; Solution: var_10035467673581685097 + var_16810041637736805964 + var_7008863358442105474 + var_18324646318698824867 + var_11695086607796217276 + var_16450119356107365534 + var_16232680044666083469 + 10 + var_6071315921843956409

(set-logic LIA)
(synth-fun synthTarget((var_10035467673581685097 Int)(var_16810041637736805964 Int)(var_7008863358442105474 Int)(var_18324646318698824867 Int)(var_11695086607796217276 Int)(var_16450119356107365534 Int)(var_16232680044666083469 Int)(var_6071315921843956409 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_10035467673581685097 var_16810041637736805964 var_7008863358442105474 var_18324646318698824867 var_11695086607796217276 var_16450119356107365534 var_16232680044666083469 var_6071315921843956409 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (synthTarget 0 0 10 91 0 91 1 1 ) 204))
(constraint (= (synthTarget 0 1 10 91 0 91 1 0 ) 204))
(constraint (= (synthTarget 0 10 0 91 91 0 1 1 ) 204))
(constraint (= (synthTarget 1 1 10 0 91 91 0 0 ) 204))
(constraint (= (synthTarget 1 10 0 91 91 0 0 1 ) 204))
(check-synth)
