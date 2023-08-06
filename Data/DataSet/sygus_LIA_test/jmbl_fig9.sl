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
( constraint  (=> (and (= x 0) (= y 0)) (inv-f x y )) ) 
( constraint  (=> (and (inv-f x y ) (and (= x! x) (and (<= 0 y) (= y! (+ x y))))) (inv-f x! y! )) ) 
( constraint  (=> (inv-f x y ) (>= y 0)) ) 
(check-synth)
