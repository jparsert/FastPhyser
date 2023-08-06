(set-logic LIA)
(synth-fun inv-f((x Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(x 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var x Int)
(declare-var x! Int)
( constraint  (=> (and (<= x (- 2)) (>= x (- 3))) (inv-f x )) ) 
( constraint  (=> (and (inv-f x ) (or (and (= x! (+ x 2)) (< x 1)) (and (= x! (+ x 1)) (>= x 1)))) (inv-f x! )) ) 
( constraint  (=> (inv-f x ) (>= x (- 5))) ) 
(check-synth)
