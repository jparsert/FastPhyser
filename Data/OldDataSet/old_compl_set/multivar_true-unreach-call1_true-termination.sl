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
( constraint  (=> (= y x) (inv-f x y )) ) 
( constraint  (=> (and (inv-f x y ) (and (< x 1024) (and (= x! (+ x 1)) (= y! (+ y 1))))) (inv-f x! y! )) ) 
( constraint  (=> (inv-f x y ) (or (< x 1024) (= x y))) ) 
(check-synth)
