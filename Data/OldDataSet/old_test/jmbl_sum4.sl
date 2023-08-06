(set-logic LIA)
(synth-fun inv-f((i Int)(sn Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(i sn 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var i Int)
(declare-var i! Int)
(declare-var sn Int)
(declare-var sn! Int)
( constraint  (=> (and (= sn 0) (= i 1)) (inv-f i sn )) ) 
( constraint  (=> (and (inv-f i sn ) (and (= i! (+ i 1)) (and (<= i 8) (= sn! (+ sn 1))))) (inv-f i! sn! )) ) 
( constraint  (=> (inv-f i sn ) (or (<= i 8) (or (= sn 8) (= sn 0)))) ) 
(check-synth)
