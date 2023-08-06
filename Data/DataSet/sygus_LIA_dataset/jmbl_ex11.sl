(set-logic LIA)
(synth-fun inv-f((c Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(c 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var c Int)
(declare-var c! Int)
( constraint  (=> (= c 0) (inv-f c )) ) 
( constraint  (=> (and (inv-f c ) (or (and (not (= c 4)) (= c! (+ c 1))) (and (= c 4) (= c! 1)))) (inv-f c! )) ) 
( constraint  (=> (inv-f c ) (not (and (not (= c 4)) (or (< c 0) (> c 4))))) ) 
(check-synth)
