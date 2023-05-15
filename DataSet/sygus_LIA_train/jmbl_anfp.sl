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
( constraint  (=> (and (= x 1) (= y 0)) (inv-f x y )) ) 
( constraint  (=> (and (inv-f x y ) (and (and (< y 1000) (= x! (+ x y))) (= y! (+ y 1)))) (inv-f x! y! )) ) 
( constraint  (=> (inv-f x y ) (not (and (>= y 1000) (< x y)))) ) 
(check-synth)
