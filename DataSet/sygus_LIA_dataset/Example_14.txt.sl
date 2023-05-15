; smt-lib-version 2.6
; source 
;  Christoph Erkinger, "Rotating Workforce Scheduling as Satisfiability Modulo
;  Theories", Master's Thesis, Technische Universitaet Wien, 2013
;
; category industrial
; status sat
; Solution: var_15151758310686021657 + var_9098293614019879250 + var_6290277126355614377 + var_955078577487246348 + var_10901177060216481772 + var_17747798634198232088 + var_7225248921726671611 + var_17747883774883210447 + var_7804032660150241426 + var_14863970982210743237 + var_4775132587973114044 + var_1245259016957443695 + var_8740376852625042528

(set-logic LIA)
(synth-fun synthTarget((var_15151758310686021657 Int)(var_9098293614019879250 Int)(var_6290277126355614377 Int)(var_955078577487246348 Int)(var_10901177060216481772 Int)(var_17747798634198232088 Int)(var_7225248921726671611 Int)(var_17747883774883210447 Int)(var_7804032660150241426 Int)(var_14863970982210743237 Int)(var_4775132587973114044 Int)(var_1245259016957443695 Int)(var_8740376852625042528 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_15151758310686021657 var_9098293614019879250 var_6290277126355614377 var_955078577487246348 var_10901177060216481772 var_17747798634198232088 var_7225248921726671611 var_17747883774883210447 var_7804032660150241426 var_14863970982210743237 var_4775132587973114044 var_1245259016957443695 var_8740376852625042528 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (synthTarget 0 0 0 0 1 0 0 14 14 1 14 1 0 ) 45))
(constraint (= (synthTarget 1 0 1 1 0 0 14 14 14 1 14 1 0 ) 61))
(constraint (= (synthTarget 1 1 1 1 1 1 1 14 183 183 14 0 14 ) 415))
(constraint (= (synthTarget 1 1 1 1 1 1 1 14 183 183 14 14 0 ) 415))
(constraint (= (synthTarget 1 1 1 1 1 14 1 14 183 183 0 0 14 ) 414))
(constraint (= (synthTarget 1 183 1 1 1 14 1 14 0 0 14 1 183 ) 414))
(constraint (= (synthTarget 1 183 1 1 1 14 14 0 0 0 14 1 183 ) 413))
(check-synth)
