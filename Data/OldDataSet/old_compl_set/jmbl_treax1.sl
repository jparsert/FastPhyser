(set-logic LIA)
(synth-fun inv-f((x Int)(y Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(x y 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var x Int)
(declare-var x! Int)
(declare-var y Int)
(declare-var y! Int)
( constraint  (=> (= x 1) (inv-f x y )) ) 
( constraint  (=> (and (inv-f x y ) (and (< x y) (= x! (+ x x)))) (inv-f x! y! )) ) 
( constraint  (=> (inv-f x y ) (or (not (>= x y)) (>= x 1))) ) 
(check-synth)
