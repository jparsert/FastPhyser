(set-logic LIA)
(synth-fun inv-f((c Int)(i Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(c i 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var c Int)
(declare-var c! Int)
(declare-var i Int)
(declare-var i! Int)
( constraint  (=> (= i 0) (inv-f c i )) ) 
( constraint  (=> (and (inv-f c i ) (and (> c 48) (and (< c 57) (= i! (+ (+ i i) (- c 48)))))) (inv-f c! i! )) ) 
( constraint  (=> (inv-f c i ) (or (> c 57) (or (< c 48) (>= i 0)))) ) 
(check-synth)
