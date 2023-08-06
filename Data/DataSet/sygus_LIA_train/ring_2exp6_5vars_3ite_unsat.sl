; Solution: (((((((((var_16232131455815782793 + var_6003155160568626111 * var_14864067151277152957) + var_2758122609746584971) + var_13494336309965953309) + var_15080775202258563266 * -64) + var_11044454761511836898 * -64) + var_1387353112620212139 * -64) + var_598682369729942257 * -64) + var_5062339458268784744 * -64) + var_3045814637280640187 * -64) + var_16015815235136721814

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

(synth-fun synthTarget((var_16232131455815782793 Int)(var_6003155160568626111 Int)(var_14864067151277152957 Int)(var_2758122609746584971 Int)(var_13494336309965953309 Int)(var_15080775202258563266 Int)(var_11044454761511836898 Int)(var_1387353112620212139 Int)(var_598682369729942257 Int)(var_5062339458268784744 Int)(var_3045814637280640187 Int)(var_16015815235136721814 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_16232131455815782793 var_6003155160568626111 var_14864067151277152957 var_2758122609746584971 var_13494336309965953309 var_15080775202258563266 var_11044454761511836898 var_1387353112620212139 var_598682369729942257 var_5062339458268784744 var_3045814637280640187 var_16015815235136721814 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (or (= (+ (- A_itev1) (* v4 2)) 128) (not (<= 64 v4))) (or (= (+ (- A_itev1) (* v4 2)) 64) (<= 64 v4))) (or (= (+ (- A_itev1) (* v4 2)) 128) (= (+ (- A_itev1) (* v4 2)) 64))) (or (<= 32 v4) (= (+ (- A_itev2) (* v4 2)) 0))) (or (not (<= 32 v4)) (= A_itev2 A_itev1))) (or (= (+ (- A_itev2) (* v4 2)) 0) (= A_itev2 A_itev1))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 128)) (* v3 2)) (* A_itev2 2))) 64) (<= 64 (+ (+ (* o_4 (- 64)) v3) A_itev2)))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 128)) (* v3 2)) (* A_itev2 2))) 128) (not (<= 64 (+ (+ (* o_4 (- 64)) v3) A_itev2))))) (or (= (+ (- A_itev3) (+ (+ (* o_4 (- 128)) (* v3 2)) (* A_itev2 2))) 128) (= (+ (- A_itev3) (+ (+ (* o_4 (- 128)) (* v3 2)) (* A_itev2 2))) 64))) (or (<= 32 (+ (+ (* o_4 (- 64)) v3) A_itev2)) (= (+ (+ (+ (* o_4 (- 128)) (* v3 2)) (* A_itev2 2)) (- A_itev4)) 0))) (or (not (<= 32 (+ (+ (* o_4 (- 64)) v3) A_itev2))) (= A_itev4 A_itev3))) (or (= (+ (+ (+ (* o_4 (- 128)) (* v3 2)) (* A_itev2 2)) (- A_itev4)) 0) (= A_itev4 A_itev3))) (or (= (+ (- A_itev5) (* v1 2)) 64) (<= 64 v1))) (or (= (+ (- A_itev5) (* v1 2)) 128) (not (<= 64 v1)))) (or (= (+ (- A_itev5) (* v1 2)) 128) (= (+ (- A_itev5) (* v1 2)) 64))) (or (<= 32 v1) (= (+ (- A_itev6) (* v1 2)) 0))) (or (not (<= 32 v1)) (= A_itev6 A_itev5))) (or (= (+ (- A_itev6) (* v1 2)) 0) (= A_itev6 A_itev5))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 0 v0) (not (<= 64 v0))) (and (<= 0 v1) (not (<= 64 v1)))) (and (<= 0 v2) (not (<= 64 v2)))) (and (<= 0 v3) (not (<= 64 v3)))) (and (<= 0 v4) (not (<= 64 v4)))) (and (<= 0 o_0) (<= o_0 1))) (and (<= 0 (+ (+ (* o_0 (- 64)) v0) A_itev6)) (not (<= 64 (+ (+ (* o_0 (- 64)) v0) A_itev6))))) (= (not (<= (+ A_itev6 v0) 64)) (= o_0 1))) (and (not (<= 4 s_1)) (<= 0 s_1))) (and (<= 0 (+ (* s_1 (- 16)) v2)) (not (<= 16 (+ (* s_1 (- 16)) v2))))) (= (<= 1 s_1) (not (<= v2 16)))) (and (not (<= 8 s_2)) (<= 0 s_2))) (and (<= 0 (+ (* s_2 (- 8)) v3)) (not (<= 8 (+ (* s_2 (- 8)) v3))))) (= (<= 1 s_2) (not (<= v3 8)))) (and (<= 0 o_1) (<= o_1 1))) (and (<= 0 (+ (* o_1 (- 16)) (+ (+ (+ (* v3 2) v2) (* s_2 (- 16))) (* s_1 (- 16))))) (not (<= 16 (+ (* o_1 (- 16)) (+ (+ (+ (* v3 2) v2) (* s_2 (- 16))) (* s_1 (- 16)))))))) (= (not (<= (+ (+ (+ (* v3 2) v2) (* s_2 (- 16))) (* s_1 (- 16))) 16)) (= o_1 1))) (and (not (<= 16 s_3)) (<= 0 s_3))) (and (<= 0 (+ (* s_3 (- 4)) v4)) (not (<= 4 (+ (* s_3 (- 4)) v4))))) (= (<= 1 s_3) (not (<= v4 4)))) (and (<= 0 o_2) (<= o_2 1))) (and (<= 0 (+ (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 64))) (* o_0 (- 64))) (* o_2 (- 64))) A_itev6)) (not (<= 64 (+ (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 64))) (* o_0 (- 64))) (* o_2 (- 64))) A_itev6))))) (= (not (<= (+ (+ (+ (+ (* v4 16) v0) (* s_3 (- 64))) (* o_0 (- 64))) A_itev6) 64)) (= o_2 1))) (and (<= 0 o_3) (<= o_3 1))) (and (<= 0 (synthTarget (+ (* v3 8) (* v4 16)) v2 4 v0 (* s_3 (- 64)) o_0 o_2 s_2 s_1 o_1 o_3 A_itev6 )) (not (<= 64 (synthTarget (+ (* v3 8) (* v4 16)) v2 4 v0 (* s_3 (- 64)) o_0 o_2 s_2 s_1 o_1 o_3 A_itev6 ))))) (= (not (<= (synthTarget (* v3 8) v4 16 (* v2 4) v0 s_3 o_0 o_2 s_2 s_1 o_1 A_itev6 ) 64)) (= o_3 1))) (and (<= 0 o_4) (<= o_4 1))) (and (<= 0 (+ (+ (* o_4 (- 64)) v3) A_itev2)) (not (<= 64 (+ (+ (* o_4 (- 64)) v3) A_itev2))))) (= (not (<= (+ A_itev2 v3) 64)) (= o_4 1))) (and (<= 0 o_5) (<= o_5 1))) (and (<= 0 (+ (+ (* o_5 (- 64)) v2) A_itev4)) (not (<= 64 (+ (+ (* o_5 (- 64)) v2) A_itev4))))) (= (not (<= (+ A_itev4 v2) 64)) (= o_5 1))) (and (not (<= 2 s_6)) (<= 0 s_6))) (and (<= 0 (+ (+ (* s_6 (- 32)) (+ (* o_5 (- 64)) v2)) A_itev4)) (not (<= 32 (+ (+ (* s_6 (- 32)) (+ (* o_5 (- 64)) v2)) A_itev4))))) (= (<= 1 s_6) (not (<= (+ (+ (* o_5 (- 64)) v2) A_itev4) 32)))) (and (<= 0 o_6) (<= o_6 1))) (and (<= 0 (+ (+ (+ (+ (+ (* o_5 (- 128)) (* v2 2)) (* s_6 (- 64))) v1) (* o_6 (- 64))) (* A_itev4 2))) (not (<= 64 (+ (+ (+ (+ (+ (* o_5 (- 128)) (* v2 2)) (* s_6 (- 64))) v1) (* o_6 (- 64))) (* A_itev4 2)))))) (= (not (<= (+ (+ (+ (+ (* o_5 (- 128)) (* v2 2)) (* s_6 (- 64))) v1) (* A_itev4 2)) 64)) (= o_6 1))) (and (not (<= 2 s_7)) (<= 0 s_7))) (and (<= 0 (+ (+ (* s_7 (- 32)) (+ (+ (+ (+ (* o_5 (- 128)) (* v2 2)) (* s_6 (- 64))) v1) (* o_6 (- 64)))) (* A_itev4 2))) (not (<= 32 (+ (+ (* s_7 (- 32)) (+ (+ (+ (+ (* o_5 (- 128)) (* v2 2)) (* s_6 (- 64))) v1) (* o_6 (- 64)))) (* A_itev4 2)))))) (= (<= 1 s_7) (not (<= (+ (+ (+ (+ (+ (* o_5 (- 128)) (* v2 2)) (* s_6 (- 64))) v1) (* o_6 (- 64))) (* A_itev4 2)) 32)))) (and (<= 0 o_7) (<= o_7 1))) (and (<= 0 (+ (+ (* o_7 (- 64)) (+ (+ (+ (+ (+ (+ (* o_5 (- 256)) (* v2 4)) (* s_6 (- 128))) (* v1 2)) (* o_6 (- 128))) (* s_7 (- 64))) v0)) (* A_itev4 4))) (not (<= 64 (+ (+ (* o_7 (- 64)) (+ (+ (+ (+ (+ (+ (* o_5 (- 256)) (* v2 4)) (* s_6 (- 128))) (* v1 2)) (* o_6 (- 128))) (* s_7 (- 64))) v0)) (* A_itev4 4)))))) (= (not (<= (+ (+ (+ (+ (+ (+ (+ (* o_5 (- 256)) (* v2 4)) (* s_6 (- 128))) (* v1 2)) (* o_6 (- 128))) (* s_7 (- 64))) v0) (* A_itev4 4)) 64)) (= o_7 1))) (not (= (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (* v3 8) (* v4 16)) (* o_5 256)) (* s_6 128)) (* v1 (- 2))) (* o_6 128)) (* s_7 64)) (* o_7 64)) (* s_3 (- 64))) (* o_0 (- 64))) (* o_2 (- 64))) (* s_2 (- 64))) (* s_1 (- 64))) (* o_1 (- 64))) (* o_3 (- 64))) (* A_itev4 (- 4))) A_itev6) 0))))))
(check-synth)
