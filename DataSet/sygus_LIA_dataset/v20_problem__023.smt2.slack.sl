; Solution: var_958305959768837585 + -1 * var_4703994829172187906 + var_671014452021766441 + var_7226390139805058883 + var_8161639810035829263 + var_12271388544179980109 + var_10614913231316181283 + var_13640554696962750064 + var_2108709198237012372 + var_18036713249929878288 * var_18323145148996961746 + -1 * var_7079786476211946764 + var_6147297177075649431 + var_14144971178982789646 + var_16737512102197243061 + var_10323750769957080996 * var_11764146894350863372 + var_7369765709810246623 + var_14073230934982920775 + var_4922252771238393961 + var_3551683058318652250 + var_14721711964983945218

(set-logic LIA)
(declare-var x0_minus Int)

(declare-var x0_plus Int)

(declare-var x10_minus Int)

(declare-var x10_plus Int)

(declare-var x11_minus Int)

(declare-var x11_plus Int)

(declare-var x12_minus Int)

(declare-var x12_plus Int)

(declare-var x13_minus Int)

(declare-var x13_plus Int)

(declare-var x14_minus Int)

(declare-var x14_plus Int)

(declare-var x15_minus Int)

(declare-var x15_plus Int)

(declare-var x16_minus Int)

(declare-var x16_plus Int)

(declare-var x17_minus Int)

(declare-var x17_plus Int)

(declare-var x18_minus Int)

(declare-var x18_plus Int)

(declare-var x19_minus Int)

(declare-var x19_plus Int)

(declare-var x1_minus Int)

(declare-var x1_plus Int)

(declare-var x2_minus Int)

(declare-var x2_plus Int)

(declare-var x3_minus Int)

(declare-var x3_plus Int)

(declare-var x4_minus Int)

(declare-var x4_plus Int)

(declare-var x5_minus Int)

(declare-var x5_plus Int)

(declare-var x6_minus Int)

(declare-var x6_plus Int)

(declare-var x7_minus Int)

(declare-var x7_plus Int)

(declare-var x8_minus Int)

(declare-var x8_plus Int)

(declare-var x9_minus Int)

(declare-var x9_plus Int)

(synth-fun synthTarget((var_958305959768837585 Int)(var_4703994829172187906 Int)(var_671014452021766441 Int)(var_7226390139805058883 Int)(var_8161639810035829263 Int)(var_12271388544179980109 Int)(var_10614913231316181283 Int)(var_13640554696962750064 Int)(var_2108709198237012372 Int)(var_18036713249929878288 Int)(var_18323145148996961746 Int)(var_7079786476211946764 Int)(var_6147297177075649431 Int)(var_14144971178982789646 Int)(var_16737512102197243061 Int)(var_10323750769957080996 Int)(var_11764146894350863372 Int)(var_7369765709810246623 Int)(var_14073230934982920775 Int)(var_4922252771238393961 Int)(var_3551683058318652250 Int)(var_14721711964983945218 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_958305959768837585 var_4703994829172187906 var_671014452021766441 var_7226390139805058883 var_8161639810035829263 var_12271388544179980109 var_10614913231316181283 var_13640554696962750064 var_2108709198237012372 var_18036713249929878288 var_18323145148996961746 var_7079786476211946764 var_6147297177075649431 var_14144971178982789646 var_16737512102197243061 var_10323750769957080996 var_11764146894350863372 var_7369765709810246623 var_14073230934982920775 var_4922252771238393961 var_3551683058318652250 var_14721711964983945218 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (>= x19_plus 0) (>= x19_minus 0) (>= x18_plus 0) (>= x18_minus 0) (>= x16_plus 0) (>= x16_minus 0) (>= x14_plus 0) (>= x14_minus 0) (>= x13_plus 0) (>= x13_minus 0) (>= x12_plus 0) (>= x12_minus 0) (>= x11_plus 0) (>= x11_minus 0) (>= x9_plus 0) (>= x9_minus 0) (>= x6_plus 0) (>= x6_minus 0) (>= x4_plus 0) (>= x4_minus 0) (>= x2_plus 0) (>= x2_minus 0) (>= x0_plus 0) (>= x0_minus 0) (>= x17_plus 0) (>= x17_minus 0) (>= x15_plus 0) (>= x15_minus 0) (>= x10_plus 0) (>= x10_minus 0) (>= x8_plus 0) (>= x8_minus 0) (>= x5_plus 0) (>= x5_minus 0) (>= x7_plus 0) (>= x7_minus 0) (>= x3_plus 0) (>= x3_minus 0) (>= x1_plus 0) (>= x1_minus 0) (<= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x18_plus) x18_minus x16_plus (* (- 1) x16_minus) x14_plus (* (- 1) x14_minus) (* (- 1) x13_plus) x13_minus x12_plus (* (- 1) x12_minus) (* (- 1) x11_plus) x11_minus x9_plus (* (- 1) x9_minus) x6_plus (* (- 1) x6_minus) x4_plus (* (- 1) x4_minus) x2_plus (* (- 1) x2_minus) x0_plus (* (- 1) x0_minus)) 0) (<= (synthTarget x19_plus x19_minus (* (- 1) x17_plus) x17_minus x15_plus (* (- 1) x15_minus) x14_plus (* (- 1) x14_minus) x13_plus (- 1) x13_minus x10_plus x10_minus (* (- 1) x8_plus) x8_minus (- 3) x5_plus (* 3 x5_minus) (* (- 1) x4_plus) x4_minus x2_plus (* (- 1) x2_minus) ) 0) (<= (synthTarget x18_plus x18_minus x17_plus (* (- 1) x17_minus) x15_plus (* (- 1) x15_minus) x14_plus (* (- 1) x14_minus) x13_plus (- 1) x13_minus x9_plus x9_minus (* (- 1) x7_plus) x7_minus 2 x6_plus (* (- 2) x6_minus) (* (- 1) x4_plus) x4_minus (* (- 1) x0_plus) x0_minus ) 0) (<= (+ x18_plus (* (- 1) x18_minus) (* 3 x16_plus) (* (- 3) x16_minus) (* (- 1) x15_plus) x15_minus x14_plus (* (- 1) x14_minus) (* (- 1) x11_plus) x11_minus x10_plus (* (- 1) x10_minus) x9_plus (* (- 1) x9_minus) x5_plus (* (- 1) x5_minus) x4_plus (* (- 1) x4_minus)) (- 1)) (<= (+ x16_plus (* (- 1) x16_minus) x15_plus (* (- 1) x15_minus) (* (- 1) x14_plus) x14_minus (* (- 1) x13_plus) x13_minus x11_plus (* (- 1) x11_minus) x10_plus (* (- 1) x10_minus) (* (- 2) x6_plus) (* 2 x6_minus) (* (- 1) x5_plus) x5_minus x0_plus (* (- 1) x0_minus)) 0) (<= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x14_plus) x14_minus x13_plus (* (- 1) x13_minus) x12_plus (* (- 1) x12_minus) (* (- 1) x11_plus) x11_minus (* (- 1) x9_plus) x9_minus (* (- 1) x3_plus) x3_minus (* (- 1) x1_plus) x1_minus) 0) (<= (+ x19_plus (* (- 1) x19_minus) x13_plus (* (- 1) x13_minus) x10_plus (* (- 1) x10_minus) (* (- 1) x7_plus) x7_minus (* (- 2) x5_plus) (* 2 x5_minus) x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus) (* (- 2) x0_plus) (* 2 x0_minus)) 0) (<= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x18_plus) x18_minus x11_plus (* (- 1) x11_minus) (* (- 1) x10_plus) x10_minus (* (- 1) x7_plus) x7_minus x3_plus (* (- 1) x3_minus) x1_plus (* (- 1) x1_minus) x0_plus (* (- 1) x0_minus)) 0) (<= (+ x18_plus (* (- 1) x18_minus) x10_plus (* (- 1) x10_minus) x7_plus (* (- 1) x7_minus) x4_plus (* (- 1) x4_minus) (* (- 1) x2_plus) x2_minus (* (- 1) x1_plus) x1_minus x0_plus (* (- 1) x0_minus)) (- 1)) (<= (+ x18_plus (* (- 1) x18_minus) (* (- 1) x17_plus) x17_minus x15_plus (* (- 1) x15_minus) x13_plus (* (- 1) x13_minus) x9_plus (* (- 1) x9_minus) (* (- 1) x7_plus) x7_minus x5_plus (* (- 1) x5_minus)) 0) (<= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x15_plus) x15_minus (* (- 1) x11_plus) x11_minus x10_plus (* (- 1) x10_minus) (* (- 1) x8_plus) x8_minus x3_plus (* (- 1) x3_minus)) 0) (<= (+ x18_plus (* (- 1) x18_minus) x17_plus (* (- 1) x17_minus) (* (- 2) x14_plus) (* 2 x14_minus) (* (- 1) x12_plus) x12_minus x9_plus (* (- 1) x9_minus) (* (- 1) x3_plus) x3_minus) (- 1)) (<= (+ x18_plus (* (- 1) x18_minus) x16_plus (* (- 1) x16_minus) (* (- 2) x13_plus) (* 2 x13_minus) (* 2 x8_plus) (* (- 2) x8_minus) (* (- 1) x6_plus) x6_minus x1_plus (* (- 1) x1_minus)) 1) (<= (+ x15_plus (* (- 1) x15_minus) x13_plus (* (- 1) x13_minus) (* (- 1) x12_plus) x12_minus x10_plus (* (- 1) x10_minus) (* (- 1) x5_plus) x5_minus (* (- 1) x4_plus) x4_minus) (- 1)) (<= (+ (* 2 x19_plus) (* (- 2) x19_minus) x18_plus (* (- 1) x18_minus) (* 2 x16_plus) (* (- 2) x16_minus) (* (- 1) x3_plus) x3_minus x1_plus (* (- 1) x1_minus) (* (- 1) x0_plus) x0_minus) 0) (<= (+ (* 2 x17_plus) (* (- 2) x17_minus) x16_plus (* (- 1) x16_minus) x14_plus (* (- 1) x14_minus) x12_plus (* (- 1) x12_minus) (* (- 1) x5_plus) x5_minus x2_plus (* (- 1) x2_minus)) 0) (<= (+ x14_plus (* (- 1) x14_minus) (* (- 1) x13_plus) x13_minus x12_plus (* (- 1) x12_minus) (* (- 1) x11_plus) x11_minus (* (- 1) x5_plus) x5_minus (* (- 1) x4_plus) x4_minus) 0) (<= (+ x14_plus (* (- 1) x14_minus) (* (- 1) x13_plus) x13_minus x12_plus (* (- 1) x12_minus) (* 2 x4_plus) (* (- 2) x4_minus) x2_plus (* (- 1) x2_minus)) 1) (<= (+ x14_plus (* (- 1) x14_minus) x13_plus (* (- 1) x13_minus) (* 2 x9_plus) (* (- 2) x9_minus) (* (- 1) x2_plus) x2_minus) 0) (>= (synthTarget x17_plus x17_minus x16_plus (* (- 1) x16_minus) (* (- 1) x14_plus) x14_minus (* (- 1) x13_plus) x13_minus (* (- 2) x11_plus) 2 x11_minus x9_plus x9_minus x8_plus (* (- 1) x8_minus) (- 1) x6_plus x6_minus x3_plus (* (- 1) x3_minus) (* (- 1) x2_plus) x2_minus ) 0) (>= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x17_plus) x17_minus (* (- 1) x15_plus) x15_minus x14_plus (* (- 1) x14_minus) x13_plus (* (- 1) x13_minus) (* (- 1) x6_plus) x6_minus (* (- 1) x4_plus) x4_minus x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus)) 0) (>= (+ x18_plus (* (- 1) x18_minus) (* (- 1) x15_plus) x15_minus x11_plus (* (- 1) x11_minus) (* (- 2) x10_plus) (* 2 x10_minus) (* (- 1) x9_plus) x9_minus (* (- 1) x8_plus) x8_minus (* (- 1) x6_plus) x6_minus x2_plus (* (- 1) x2_minus) (* (- 1) x0_plus) x0_minus) 0) (>= (+ x17_plus (* (- 1) x17_minus) x11_plus (* (- 1) x11_minus) x10_plus (* (- 1) x10_minus) (* (- 1) x5_plus) x5_minus (* (- 1) x4_plus) x4_minus x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus) x0_plus (* (- 1) x0_minus)) 1) (>= (+ (* 2 x19_plus) (* (- 2) x19_minus) (* (- 2) x18_plus) (* 2 x18_minus) x16_plus (* (- 1) x16_minus) (* 2 x15_plus) (* (- 2) x15_minus) (* (- 1) x13_plus) x13_minus (* (- 1) x7_plus) x7_minus x0_plus (* (- 1) x0_minus)) 1) (>= (+ x17_plus (* (- 1) x17_minus) (* (- 2) x16_plus) (* 2 x16_minus) x15_plus (* (- 1) x15_minus) x14_plus (* (- 1) x14_minus) (* 2 x9_plus) (* (- 2) x9_minus) (* (- 1) x8_plus) x8_minus (* 2 x0_plus) (* (- 2) x0_minus)) 0) (>= (+ x14_plus (* (- 1) x14_minus) x10_plus (* (- 1) x10_minus) (* 3 x9_plus) (* (- 3) x9_minus) x7_plus (* (- 1) x7_minus) x6_plus (* (- 1) x6_minus) (* (- 1) x2_plus) x2_minus (* (- 2) x1_plus) (* 2 x1_minus)) 0) (>= (+ x14_plus (* (- 1) x14_minus) (* (- 1) x13_plus) x13_minus (* 3 x9_plus) (* (- 3) x9_minus) (* 2 x6_plus) (* (- 2) x6_minus) x2_plus (* (- 1) x2_minus) (* (- 2) x1_plus) (* 2 x1_minus) (* (- 1) x0_plus) x0_minus) (- 1)) (>= (+ x12_plus (* (- 1) x12_minus) (* (- 2) x9_plus) (* 2 x9_minus) (* (- 1) x8_plus) x8_minus (* 2 x7_plus) (* (- 2) x7_minus) (* (- 1) x6_plus) x6_minus (* (- 1) x5_plus) x5_minus x2_plus (* (- 1) x2_minus)) 1) (>= (+ x18_plus (* (- 1) x18_minus) (* (- 1) x17_plus) x17_minus (* (- 1) x15_plus) x15_minus (* (- 1) x12_plus) x12_minus (* (- 1) x11_plus) x11_minus (* (- 1) x5_plus) x5_minus (* 2 x4_plus) (* (- 2) x4_minus)) 0) (>= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x16_plus) x16_minus x15_plus (* (- 1) x15_minus) (* (- 1) x14_plus) x14_minus (* 2 x11_plus) (* (- 2) x11_minus) x2_plus (* (- 1) x2_minus)) 0) (>= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x13_plus) x13_minus x11_plus (* (- 1) x11_minus) (* (- 1) x9_plus) x9_minus x7_plus (* (- 1) x7_minus) (* (- 1) x2_plus) x2_minus) 0) (>= (+ x16_plus (* (- 1) x16_minus) (* (- 1) x14_plus) x14_minus x13_plus (* (- 1) x13_minus) (* (- 1) x6_plus) x6_minus x1_plus (* (- 1) x1_minus) x0_plus (* (- 1) x0_minus)) 1) (>= (+ x17_plus (* (- 1) x17_minus) x16_plus (* (- 1) x16_minus) x14_plus (* (- 1) x14_minus) (* (- 2) x13_plus) (* 2 x13_minus) (* (- 1) x9_plus) x9_minus (* (- 1) x6_plus) x6_minus) 1) (>= (+ x18_plus (* (- 1) x18_minus) x14_plus (* (- 1) x14_minus) (* (- 2) x10_plus) (* 2 x10_minus) (* (- 1) x9_plus) x9_minus (* (- 1) x8_plus) x8_minus (* (- 1) x6_plus) x6_minus) 0) (>= (+ (* 2 x12_plus) (* (- 2) x12_minus) (* 2 x11_plus) (* (- 2) x11_minus) (* (- 2) x5_plus) (* 2 x5_minus) x4_plus (* (- 1) x4_minus) x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus)) 0) (>= (+ x15_plus (* (- 1) x15_minus) (* (- 1) x13_plus) x13_minus x11_plus (* (- 1) x11_minus) (* (- 1) x8_plus) x8_minus x4_plus (* (- 1) x4_minus) (* (- 1) x1_plus) x1_minus) 1) (>= (+ x12_plus (* (- 1) x12_minus) x11_plus (* (- 1) x11_minus) x8_plus (* (- 1) x8_minus) (* (- 1) x6_plus) x6_minus (* (- 1) x0_plus) x0_minus) (- 1)) (>= (+ x18_plus (* (- 1) x18_minus) x12_plus (* (- 1) x12_minus) (* (- 1) x8_plus) x8_minus (* (- 1) x5_plus) x5_minus (* (- 1) x4_plus) x4_minus) 0) (>= (+ x12_plus (* (- 1) x12_minus) (* (- 1) x11_plus) x11_minus x9_plus (* (- 1) x9_minus) x8_plus (* (- 1) x8_minus) x2_plus (* (- 1) x2_minus)) 0) (>= (+ x19_plus (* (- 1) x19_minus) (* (- 1) x8_plus) x8_minus x7_plus (* (- 1) x7_minus) x6_plus (* (- 1) x6_minus)) (- 1)))))
(check-synth)
