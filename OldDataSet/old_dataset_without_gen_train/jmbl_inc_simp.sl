(set-logic LIA)
(synth-fun inv-f((x Int)(n Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(x n 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var n Int)
(declare-var n! Int)
(declare-var x Int)
(declare-var x! Int)
( constraint  (=> (= x 0) (inv-f x n )) ) 
( constraint  (=> (and (inv-f x n ) (and (= n! n) (and (< x n) (= x! (+ x 1))))) (inv-f x! n! )) ) 
( constraint  (=> (inv-f x n ) (or (not (>= x n)) (or (= x n) (< n 0)))) ) 
(check-synth)
