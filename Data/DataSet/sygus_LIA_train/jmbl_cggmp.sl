(set-logic LIA)
(synth-fun inv-f((i Int)(j Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(i j 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var i Int)
(declare-var i! Int)
(declare-var j Int)
(declare-var j! Int)
( constraint  (=> (and (= i 1) (= j 10)) (inv-f i j )) ) 
( constraint  (=> (and (inv-f i j ) (and (and (>= j i) (= i! (+ i 2))) (= j! (- j 1)))) (inv-f i! j! )) ) 
( constraint  (=> (inv-f i j ) (not (and (< j i) (not (= j 6))))) ) 
(check-synth)
