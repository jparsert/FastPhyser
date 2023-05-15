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
( constraint  (=> (and (<= x 5) (>= x 4) (<= y 5) (>= y 4)) (inv-f x y )) ) 
( constraint  (=> (and (inv-f x y ) (or (and (= x! (- x 1)) (= y! y) (>= x 0) (>= y 0)) (and (= x! x) (= y! (- y 1)) (< x 0) (>= y 0)) (and (= x! (+ x 1)) (= y! (- y 1)) (< y 0)))) (inv-f x! y! )) ) 
( constraint  (=> (inv-f x y ) (<= y 5)) ) 
(check-synth)
