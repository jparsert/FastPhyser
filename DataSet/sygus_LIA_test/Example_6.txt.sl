; smt-lib-version 2.6
; source 
;  Christoph Erkinger, "Rotating Workforce Scheduling as Satisfiability Modulo
;  Theories", Master's Thesis, Technische Universitaet Wien, 2013
;
; category industrial
; status sat
; Solution: var_10827059244774493225 + var_16375352364596707993 + var_12629844561987712523 + var_13135011118310300608 + var_957140909245389385 + var_5568246240290915970 + var_2758850340737499552

(set-logic LIA)
(synth-fun synthTarget((var_10827059244774493225 Int)(var_16375352364596707993 Int)(var_12629844561987712523 Int)(var_13135011118310300608 Int)(var_957140909245389385 Int)(var_5568246240290915970 Int)(var_2758850340737499552 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_10827059244774493225 var_16375352364596707993 var_12629844561987712523 var_13135011118310300608 var_957140909245389385 var_5568246240290915970 var_2758850340737499552 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (synthTarget 0 57 57 1 8 8 1 ) 132))
(constraint (= (synthTarget 57 57 0 0 0 0 0 ) 114))
(constraint (= (synthTarget 8 0 0 1 8 0 1 ) 18))
(constraint (= (synthTarget 8 0 57 1 8 57 1 ) 132))
(check-synth)
