; Solution: (((((((((var_1965335537918358972 + var_16089257865323138994 * var_886121476111578783) + var_12560324214360424852) + var_10683179798152960549) + var_10466823834872922783 * -16) + var_14576854404667268430 * -16) + var_2107903578082938840 * -16) + var_4703075163406432605 * -16) + var_10539437692181260712 * -16) + var_1822991214886993638 * -16) + var_17962792428684174495

(set-logic LIA)
(declare-var A_itev1 Int)

(declare-var A_itev2 Int)

(declare-var A_itev3 Int)

(declare-var A_itev4 Int)

(declare-var A_itev5 Int)

(declare-var A_itev6 Int)

(declare-var o_0 Int)

(declare-var o_1 Int)

(declare-var o_2 Int)

(declare-var o_3 Int)

(declare-var o_4 Int)

(declare-var o_5 Int)

(declare-var o_6 Int)

(declare-var o_7 Int)

(declare-var s_1 Int)

(declare-var s_2 Int)

(declare-var s_3 Int)

(declare-var s_6 Int)

(declare-var s_7 Int)

(declare-var v0 Int)

(declare-var v1 Int)

(declare-var v2 Int)

(declare-var v3 Int)

(declare-var v4 Int)

(synth-fun synthTarget((var_1965335537918358972 Int)(var_16089257865323138994 Int)(var_886121476111578783 Int)(var_12560324214360424852 Int)(var_10683179798152960549 Int)(var_10466823834872922783 Int)(var_14576854404667268430 Int)(var_2107903578082938840 Int)(var_4703075163406432605 Int)(var_10539437692181260712 Int)(var_1822991214886993638 Int)(var_17962792428684174495 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_1965335537918358972 var_16089257865323138994 var_886121476111578783 var_12560324214360424852 var_10683179798152960549 var_10466823834872922783 var_14576854404667268430 var_2107903578082938840 var_4703075163406432605 var_10539437692181260712 var_1822991214886993638 var_17962792428684174495 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (or (= (+ (- A_itev1) (* v4 2)) 32) (not (<= 16 v4))) (or (= (+ (- A_itev1) (* v4 2)) 16) (<= 16 v4))) (or (= (+ (- A_itev1) (* v4 2)) 32) (= (+ (- A_itev1) (* v4 2)) 16))) (or (<= 8 v4) (= (+ (- A_itev2) (* v4 2)) 0))) (or (not (<= 8 v4)) (= A_itev2 A_itev1))) (or (= (+ (- A_itev2) (* v4 2)) 0) (= A_itev2 A_itev1))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 16) (<= 16 (+ (+ (* o_4 (- 16)) v3) A_itev2)))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 32) (not (<= 16 (+ (+ (* o_4 (- 16)) v3) A_itev2))))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 32) (= (+ (- A_itev3) (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2))) 16))) (or (<= 8 (+ (+ (* o_4 (- 16)) v3) A_itev2)) (= (+ (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2)) (- A_itev4)) 0))) (or (not (<= 8 (+ (+ (* o_4 (- 16)) v3) A_itev2))) (= A_itev4 A_itev3))) (or (= (+ (+ (+ (* o_4 (- 32)) (* v3 2)) (* A_itev2 2)) (- A_itev4)) 0) (= A_itev4 A_itev3))) (or (= (+ (- A_itev5) (* v1 2)) 16) (<= 16 v1))) (or (= (+ (- A_itev5) (* v1 2)) 32) (not (<= 16 v1)))) (or (= (+ (- A_itev5) (* v1 2)) 32) (= (+ (- A_itev5) (* v1 2)) 16))) (or (<= 8 v1) (= (+ (- A_itev6) (* v1 2)) 0))) (or (not (<= 8 v1)) (= A_itev6 A_itev5))) (or (= (+ (- A_itev6) (* v1 2)) 0) (= A_itev6 A_itev5))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 0 v0) (not (<= 16 v0))) (and (<= 0 v1) (not (<= 16 v1)))) (and (<= 0 v2) (not (<= 16 v2)))) (and (<= 0 v3) (not (<= 16 v3)))) (and (<= 0 v4) (not (<= 16 v4)))) (and (<= 0 o_0) (<= o_0 1))) (and (<= 0 (+ (+ (* o_0 (- 16)) v0) A_itev6)) (not (<= 16 (+ (+ (* o_0 (- 16)) v0) A_itev6))))) (= (not (<= (+ A_itev6 v0) 16)) (= o_0 1))) (and (not (<= 4 s_1)) (<= 0 s_1))) (and (<= 0 (+ (* s_1 (- 4)) v2)) (not (<= 4 (+ (* s_1 (- 4)) v2))))) (= (<= 1 s_1) (not (<= v2 4)))) (and (not (<= 8 s_2)) (<= 0 s_2))) (and (<= 0 (+ (* s_2 (- 2)) v3)) (not (<= 2 (+ (* s_2 (- 2)) v3))))) (= (<= 1 s_2) (not (<= v3 2)))) (and (<= 0 o_1) (<= o_1 1))) (and (<= 0 (+ (* o_1 (- 4)) (+ (+ (+ (* v3 2) v2) (* s_2 (- 4))) (* s_1 (- 4))))) (not (<= 4 (+ (* o_1 (- 4)) (+ (+ (+ (* v3 2) v2) (* s_2 (- 4))) (* s_1 (- 4)))))))) (= (not (<= (+ (+ (+ (* v3 2) v2) (* s_2 (- 4))) (* s_1 (- 4))) 4)) (= o_1 1))) (and (not (<= 16 s_3)) (<= 0 s_3))) (and (<= s_3 v4) (not (<= 1 (- v4 s_3))))) (= (<= 1 s_3) (not (<= v4 1)))) (and (<= 0 o_2) (<= o_2 1))) (and (<= 0 (+ (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 16))) (* o_0 (- 16))) (* o_2 (- 16))) A_itev6)) (not (<= 16 (+ (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 16))) (* o_0 (- 16))) (* o_2 (- 16))) A_itev6))))) (= (not (<= (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 16))) (* o_0 (- 16))) A_itev6) 16)) (= o_2 1))) (and (<= 0 o_3) (<= o_3 1))) (and (<= 0 (synthTarget (+ (* v3 8) (* v4 16)) v2 4 v0 (* s_3 (- 16)) o_0 o_2 s_2 s_1 o_1 o_3 A_itev6 )) (not (<= 16 (synthTarget (+ (* v3 8) (* v4 16)) v2 4 v0 (* s_3 (- 16)) o_0 o_2 s_2 s_1 o_1 o_3 A_itev6 ))))) (= (not (<= (synthTarget (* v3 8) v4 16 (* v2 4) v0 s_3 o_0 o_2 s_2 s_1 o_1 A_itev6 ) 16)) (= o_3 1))) (and (<= 0 o_4) (<= o_4 1))) (and (<= 0 (+ (+ (* o_4 (- 16)) v3) A_itev2)) (not (<= 16 (+ (+ (* o_4 (- 16)) v3) A_itev2))))) (= (not (<= (+ A_itev2 v3) 16)) (= o_4 1))) (and (<= 0 o_5) (<= o_5 1))) (and (<= 0 (+ (+ (* o_5 (- 16)) v2) A_itev4)) (not (<= 16 (+ (+ (* o_5 (- 16)) v2) A_itev4))))) (= (not (<= (+ A_itev4 v2) 16)) (= o_5 1))) (and (not (<= 2 s_6)) (<= 0 s_6))) (and (<= 0 (+ (+ (* s_6 (- 8)) (+ (* o_5 (- 16)) v2)) A_itev4)) (not (<= 8 (+ (+ (* s_6 (- 8)) (+ (* o_5 (- 16)) v2)) A_itev4))))) (= (<= 1 s_6) (not (<= (+ (+ (* o_5 (- 16)) v2) A_itev4) 8)))) (and (<= 0 o_6) (<= o_6 1))) (and (<= 0 (+ (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16))) (* A_itev4 2))) (not (<= 16 (+ (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16))) (* A_itev4 2)))))) (= (not (<= (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* A_itev4 2)) 16)) (= o_6 1))) (and (not (<= 2 s_7)) (<= 0 s_7))) (and (<= 0 (+ (+ (* s_7 (- 8)) (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16)))) (* A_itev4 2))) (not (<= 8 (+ (+ (* s_7 (- 8)) (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16)))) (* A_itev4 2)))))) (= (<= 1 s_7) (not (<= (+ (+ (+ (+ (+ (* o_5 (- 32)) (* v2 2)) (* s_6 (- 16))) v1) (* o_6 (- 16))) (* A_itev4 2)) 8)))) (and (<= 0 o_7) (<= o_7 1))) (and (<= 0 (+ (+ (* o_7 (- 16)) (+ (+ (+ (+ (+ (+ (* o_5 (- 64)) (* v2 4)) (* s_6 (- 32))) (* v1 2)) (* o_6 (- 32))) (* s_7 (- 16))) v0)) (* A_itev4 4))) (not (<= 16 (+ (+ (* o_7 (- 16)) (+ (+ (+ (+ (+ (+ (* o_5 (- 64)) (* v2 4)) (* s_6 (- 32))) (* v1 2)) (* o_6 (- 32))) (* s_7 (- 16))) v0)) (* A_itev4 4)))))) (= (not (<= (+ (+ (+ (+ (+ (+ (+ (* o_5 (- 64)) (* v2 4)) (* s_6 (- 32))) (* v1 2)) (* o_6 (- 32))) (* s_7 (- 16))) v0) (* A_itev4 4)) 16)) (= o_7 1))) (not (= (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (* v3 8) (* v4 16)) (* o_5 64)) (* s_6 32)) (* v1 (- 2))) (* o_6 32)) (* s_7 16)) (* o_7 16)) (* s_3 (- 16))) (* o_0 (- 16))) (* o_2 (- 16))) (* s_2 (- 16))) (* s_1 (- 16))) (* o_1 (- 16))) (* o_3 (- 16))) (* A_itev4 (- 4))) A_itev6) 0))))))
(check-synth)
