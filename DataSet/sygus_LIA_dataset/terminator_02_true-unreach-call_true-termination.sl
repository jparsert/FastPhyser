(set-logic LIA)
(synth-fun inv-f((x Int)(z Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(x z 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var x Int)
(declare-var x! Int)
(declare-var z Int)
(declare-var z! Int)
( constraint  (=> (and (> x (- 0 100)) (< x 200) (> z 100) (< z 200)) (inv-f x z )) ) 
( constraint  (=> (and (inv-f x z ) (and (< x 100) (> z 100) (or (and (= x! (+ x 1)) (= z! z)) (and (= x! (- x 1)) (= z! (- z 1)))))) (inv-f x! z! )) ) 
( constraint  (=> (inv-f x z ) (or (and (< x 100) (> z 100)) (or (>= x 100) (<= z 100)))) ) 
(check-synth)
