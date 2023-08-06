(set-logic LIA)
(synth-fun inv-f((c Int)(n Int))
 Bool
(( NTbool Bool)(NTnonbool Int))
((NTbool Bool((and NTbool NTbool)(or NTbool NTbool)(not NTbool)(= NTnonbool NTnonbool)(>= NTnonbool NTnonbool)(> NTnonbool NTnonbool)))
(NTnonbool Int(c n 0 1 2 3  (+ NTnonbool NTnonbool)(- NTnonbool NTnonbool)(- NTnonbool)(ite NTbool NTnonbool NTnonbool)))

)
)

(declare-var c Int)
(declare-var c! Int)
(declare-var n Int)
(declare-var n! Int)
( constraint  (=> (and (= c 0) (> n 0)) (inv-f c n )) ) 
( constraint  (=> (and (inv-f c n ) (or (and (and (not (= c n)) (= c! (+ c 1))) (= n! n)) (and (and (= c n) (= c! 1)) (= n! n)))) (inv-f c! n! )) ) 
( constraint  (=> (inv-f c n ) (and (or (= c n) (and (>= c 0) (<= c n))) (or (not (= c n)) (> n (- 1))))) ) 
(check-synth)
