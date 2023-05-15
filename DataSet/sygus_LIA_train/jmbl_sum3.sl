(set-logic LIA)
(synth-fun inv-f((x Int)(sn Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(x sn 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var sn Int)
(declare-var sn! Int)
(declare-var x Int)
(declare-var x! Int)
( constraint  (=> (and (= sn 0) (= x 0)) (inv-f x sn )) ) 
( constraint  (=> (and (inv-f x sn ) (and (= x! (+ x 1)) (= sn! (+ sn 1)))) (inv-f x! sn! )) ) 
( constraint  (=> (inv-f x sn ) (or (= sn x) (= sn (- 1)))) ) 
(check-synth)
