; Solution: ((((((((var_5496177165692085070 * 8 + var_15366534189331238649 * 16) + var_16163299052036968394) + var_12340321547916639937 * -16) + var_11764457096371749546 * -16) + var_11259277108811021069 * -16) + var_13567204645524660583 * -16) + var_4198931733673607764 * -16) + var_10758498811404508432) + var_5065174744970352336

(set-logic LIA)
(declare-var A_itev1 Int)

(declare-var A_itev10 Int)

(declare-var A_itev2 Int)

(declare-var A_itev3 Int)

(declare-var A_itev4 Int)

(declare-var A_itev5 Int)

(declare-var A_itev6 Int)

(declare-var A_itev7 Int)

(declare-var A_itev8 Int)

(declare-var A_itev9 Int)

(declare-var o_0 Int)

(declare-var o_1 Int)

(declare-var o_2 Int)

(declare-var o_3 Int)

(declare-var o_4 Int)

(declare-var o_5 Int)

(declare-var o_6 Int)

(declare-var o_7 Int)

(declare-var s_2 Int)

(declare-var s_3 Int)

(declare-var s_6 Int)

(declare-var s_7 Int)

(declare-var v0 Int)

(declare-var v1 Int)

(declare-var v2 Int)

(declare-var v3 Int)

(declare-var v4 Int)

(synth-fun synthTarget((var_5496177165692085070 Int)(var_15366534189331238649 Int)(var_16163299052036968394 Int)(var_12340321547916639937 Int)(var_11764457096371749546 Int)(var_11259277108811021069 Int)(var_13567204645524660583 Int)(var_4198931733673607764 Int)(var_10758498811404508432 Int)(var_5065174744970352336 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_5496177165692085070 var_15366534189331238649 var_16163299052036968394 var_12340321547916639937 var_11764457096371749546 var_11259277108811021069 var_13567204645524660583 var_4198931733673607764 var_10758498811404508432 var_5065174744970352336 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (or (= (+ (- A_itev1) (* v4 2)) 32) (not (<= 16 v4))) (or (= (+ (- A_itev1) (* v4 2)) 16) (<= 16 v4))) (or (= (+ (- A_itev1) (* v4 2)) 32) (= (+ (- A_itev1) (* v4 2)) 16))) (or (<= 8 v4) (= (+ (- A_itev2) (* v4 2)) 0))) (or (not (<= 8 v4)) (= A_itev2 A_itev1))) (or (= (+ (- A_itev2) (* v4 2)) 0) (= A_itev2 A_itev1))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 16) (<= 16 (+ (+ (* o_4 (- 16)) v3) A_itev2)))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 32) (not (<= 16 (+ (+ (* o_4 (- 16)) v3) A_itev2))))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 32) (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 16))) (or (<= 8 (+ (+ (* o_4 (- 16)) v3) A_itev2)) (= (+ (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2)) (- A_itev4)) 0))) (or (not (<= 8 (+ (+ (* o_4 (- 16)) v3) A_itev2))) (= A_itev4 A_itev3))) (or (= (+ (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2)) (- A_itev4)) 0) (= A_itev4 A_itev3))) (or (= (+ (- A_itev5) (* v1 2)) 16) (<= 16 v1))) (or (= (+ (- A_itev5) (* v1 2)) 32) (not (<= 16 v1)))) (or (= (+ (- A_itev5) (* v1 2)) 32) (= (+ (- A_itev5) (* v1 2)) 16))) (or (<= 8 v1) (= (+ (- A_itev6) (* v1 2)) 0))) (or (not (<= 8 v1)) (= A_itev6 A_itev5))) (or (= (+ (- A_itev6) (* v1 2)) 0) (= A_itev6 A_itev5))) (or (= (+ (- A_itev7) (* v2 4)) 48) (<= 16 v2))) (or (= (+ (- A_itev7) (* v2 4)) 64) (not (<= 16 v2)))) (or (= (+ (- A_itev7) (* v2 4)) 64) (= (+ (- A_itev7) (* v2 4)) 48))) (or (<= 12 v2) (= (+ (- A_itev8) (* v2 4)) 32))) (or (not (<= 12 v2)) (= A_itev8 A_itev7))) (or (= (+ (- A_itev8) (* v2 4)) 32) (= A_itev8 A_itev7))) (or (<= 8 v2) (= (+ (- A_itev9) (* v2 4)) 16))) (or (not (<= 8 v2)) (= A_itev9 A_itev8))) (or (= (+ (- A_itev9) (* v2 4)) 16) (= A_itev9 A_itev8))) (or (<= 4 v2) (= (+ (- A_itev10) (* v2 4)) 0))) (or (not (<= 4 v2)) (= A_itev10 A_itev9))) (or (= (+ (- A_itev10) (* v2 4)) 0) (= A_itev10 A_itev9))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 0 v0) (not (<= 16 v0))) (and (<= 0 v1) (not (<= 16 v1)))) (and (<= 0 v2) (not (<= 16 v2)))) (and (<= 0 v3) (not (<= 16 v3)))) (and (<= 0 v4) (not (<= 16 v4)))) (and (<= 0 o_0) (<= o_0 1))) (and (<= 0 (+ (+ (* o_0 (- 16)) v0) A_itev6)) (not (<= 16 (+ (+ (* o_0 (- 16)) v0) A_itev6))))) (= (not (<= (+ A_itev6 v0) 16)) (= o_0 1))) (and (not (<= 8 s_2)) (<= 0 s_2))) (and (<= 0 (+ (* s_2 (- 2)) v3)) (not (<= 2 (+ (* s_2 (- 2)) v3))))) (= (<= 1 s_2) (not (<= v3 2)))) (and (<= 0 o_1) (<= o_1 1))) (and (<= 0 (+ (+ (+ (* s_2 (- 16)) (* v3 8)) (* o_1 (- 16))) A_itev10)) (not (<= 16 (+ (+ (+ (* s_2 (- 16)) (* v3 8)) (* o_1 (- 16))) A_itev10))))) (= (not (<= (+ (+ (* s_2 (- 16)) (* v3 8)) A_itev10) 16)) (= o_1 1))) (and (not (<= 16 s_3)) (<= 0 s_3))) (and (<= s_3 v4) (not (<= 1 (- v4 s_3))))) (= (<= 1 s_3) (not (<= v4 1)))) (and (<= 0 o_2) (<= o_2 1))) (and (<= 0 (+ (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 16))) (* o_0 (- 16))) (* o_2 (- 16))) A_itev6)) (not (<= 16 (+ (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 16))) (* o_0 (- 16))) (* o_2 (- 16))) A_itev6))))) (= (not (<= (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 16))) (* o_0 (- 16))) A_itev6) 16)) (= o_2 1))) (and (<= 0 o_3) (<= o_3 1))) (and (<= 0 (+ (synthTarget v3 v4 v0 s_3 o_0 o_2 s_2 o_1 (* o_3 (- 16)) A_itev6 ) A_itev10)) (not (<= 16 (+ (synthTarget v3 v4 v0 s_3 o_0 o_2 s_2 o_1 (* o_3 (- 16)) A_itev6 ) A_itev10))))) (= (not (<= (synthTarget v3 v4 v0 s_3 o_0 o_2 s_2 o_1 A_itev6 A_itev10 ) 16)) (= o_3 1))) (and (<= 0 o_4) (<= o_4 1))) (and (<= 0 (+ (+ (* o_4 (- 16)) v3) A_itev2)) (not (<= 16 (+ (+ (* o_4 (- 16)) v3) A_itev2))))) (= (not (<= (+ A_itev2 v3) 16)) (= o_4 1))) (and (<= 0 o_5) (<= o_5 1))) (and (<= 0 (+ (+ (* o_5 (- 16)) v2) A_itev4)) (not (<= 16 (+ (+ (* o_5 (- 16)) v2) A_itev4))))) (= (not (<= (+ A_itev4 v2) 16)) (= o_5 1))) (and (not (<= 2 s_6)) (<= 0 s_6))) (and (<= 0 (+ (+ (* s_6 (- 8)) (+ (* o_5 (- 16)) v2)) A_itev4)) (not (<= 8 (+ (+ (* s_6 (- 8)) (+ (* o_5 (- 16)) v2)) A_itev4))))) (= (<= 1 s_6) (not (<= (+ (+ (* o_5 (- 16)) v2) A_itev4) 8)))) (and (<= 0 o_6) (<= o_6 1))) (and (<= 0 (+ (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16))) (* A_itev4 2))) (not (<= 16 (+ (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16))) (* A_itev4 2)))))) (= (not (<= (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* A_itev4 2)) 16)) (= o_6 1))) (and (not (<= 2 s_7)) (<= 0 s_7))) (and (<= 0 (+ (+ (* s_7 (- 8)) (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16)))) (* A_itev4 2))) (not (<= 8 (+ (+ (* s_7 (- 8)) (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16)))) (* A_itev4 2)))))) (= (<= 1 s_7) (not (<= (+ (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16))) (* A_itev4 2)) 8)))) (and (<= 0 o_7) (<= o_7 1))) (and (<= 0 (+ (+ (* o_7 (- 16)) (+ (+ (+ (+ (+ (+ (* o_5 (- 64)) (* v2 4)) (* s_6 (- 32))) (* v1 2)) (* o_6 (- 32))) (* s_7 (- 16))) v0)) (* A_itev4 4))) (not (<= 16 (+ (+ (* o_7 (- 16)) (+ (+ (+ (+ (+ (+ (* o_5 (- 64)) (* v2 4)) (* s_6 (- 32))) (* v1 2)) (* o_6 (- 32))) (* s_7 (- 16))) v0)) (* A_itev4 4)))))) (= (not (<= (+ (+ (+ (+ (+ (+ (+ (* o_5 (- 64)) (* v2 4)) (* s_6 (- 32))) (* v1 2)) (* o_6 (- 32))) (* s_7 (- 16))) v0) (* A_itev4 4)) 16)) (= o_7 1))) (not (= (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (* v3 8) (* v4 16)) (* v2 (- 4))) (* o_5 64)) (* s_6 32)) (* v1 (- 2))) (* o_6 32)) (* s_7 16)) (* o_7 16)) (* s_3 (- 16))) (* o_0 (- 16))) (* o_2 (- 16))) (* s_2 (- 16))) (* o_1 (- 16))) (* o_3 (- 16))) (* A_itev4 (- 4))) A_itev6) A_itev10) 0))))))
(check-synth)
