; Solution: var_6578816553974489325 + -1 * var_18036400833138297921 + var_10686850951646778162 + var_1966830776510272102 * var_15082233116432655733 + var_10395805312821922098 + var_8019455369203617016 + var_5856879840707726477 + var_17312380009175939854 + var_15150316379557701759 + -1 * var_18771563971037025 + var_6433974450976158820 + var_13856036844271690131 + var_15512799941668743088 + var_13421629806128486110 + var_4703088499488957009 + var_15800063056536266266 + var_9029404004047065304 + var_13781425143582851199 + var_12484276011790551022 + var_16377230378433461654 + var_7947012505397844402 + var_10038366122148637937

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

(declare-var x20_minus Int)

(declare-var x20_plus Int)

(declare-var x21_minus Int)

(declare-var x21_plus Int)

(declare-var x22_minus Int)

(declare-var x22_plus Int)

(declare-var x23_minus Int)

(declare-var x23_plus Int)

(declare-var x24_minus Int)

(declare-var x24_plus Int)

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

(synth-fun synthTarget((var_6578816553974489325 Int)(var_18036400833138297921 Int)(var_10686850951646778162 Int)(var_1966830776510272102 Int)(var_15082233116432655733 Int)(var_10395805312821922098 Int)(var_8019455369203617016 Int)(var_5856879840707726477 Int)(var_17312380009175939854 Int)(var_15150316379557701759 Int)(var_18771563971037025 Int)(var_6433974450976158820 Int)(var_13856036844271690131 Int)(var_15512799941668743088 Int)(var_13421629806128486110 Int)(var_4703088499488957009 Int)(var_15800063056536266266 Int)(var_9029404004047065304 Int)(var_13781425143582851199 Int)(var_12484276011790551022 Int)(var_16377230378433461654 Int)(var_7947012505397844402 Int)(var_10038366122148637937 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_6578816553974489325 var_18036400833138297921 var_10686850951646778162 var_1966830776510272102 var_15082233116432655733 var_10395805312821922098 var_8019455369203617016 var_5856879840707726477 var_17312380009175939854 var_15150316379557701759 var_18771563971037025 var_6433974450976158820 var_13856036844271690131 var_15512799941668743088 var_13421629806128486110 var_4703088499488957009 var_15800063056536266266 var_9029404004047065304 var_13781425143582851199 var_12484276011790551022 var_16377230378433461654 var_7947012505397844402 var_10038366122148637937 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (>= x24_plus 0) (>= x24_minus 0) (>= x23_plus 0) (>= x23_minus 0) (>= x20_plus 0) (>= x20_minus 0) (>= x19_plus 0) (>= x19_minus 0) (>= x16_plus 0) (>= x16_minus 0) (>= x15_plus 0) (>= x15_minus 0) (>= x14_plus 0) (>= x14_minus 0) (>= x11_plus 0) (>= x11_minus 0) (>= x8_plus 0) (>= x8_minus 0) (>= x4_plus 0) (>= x4_minus 0) (>= x3_plus 0) (>= x3_minus 0) (>= x2_plus 0) (>= x2_minus 0) (>= x0_plus 0) (>= x0_minus 0) (>= x22_plus 0) (>= x22_minus 0) (>= x12_plus 0) (>= x12_minus 0) (>= x10_plus 0) (>= x10_minus 0) (>= x9_plus 0) (>= x9_minus 0) (>= x7_plus 0) (>= x7_minus 0) (>= x1_plus 0) (>= x1_minus 0) (>= x18_plus 0) (>= x18_minus 0) (>= x17_plus 0) (>= x17_minus 0) (>= x13_plus 0) (>= x13_minus 0) (>= x5_plus 0) (>= x5_minus 0) (>= x21_plus 0) (>= x21_minus 0) (>= x6_plus 0) (>= x6_minus 0) (<= (+ x24_plus (* (- 1) x24_minus) x23_plus (* (- 1) x23_minus) (* (- 1) x20_plus) x20_minus (* (- 1) x19_plus) x19_minus x16_plus (* (- 1) x16_minus) (* (- 1) x15_plus) x15_minus (* (- 1) x14_plus) x14_minus x11_plus (* (- 1) x11_minus) x8_plus (* (- 1) x8_minus) (* 3 x4_plus) (* (- 3) x4_minus) (* (- 1) x3_plus) x3_minus x2_plus (* (- 1) x2_minus) (* 2 x0_plus) (* (- 2) x0_minus)) 1) (<= (synthTarget x22_plus x22_minus (* (- 2) x19_plus) 2 x19_minus (* 3 x16_plus) (* (- 3) x16_minus) (* (- 1) x12_plus) x12_minus x10_plus x10_minus x9_plus (* (- 1) x9_minus) (* (- 1) x7_plus) x7_minus (* (- 1) x4_plus) x4_minus (* (- 1) x2_plus) x2_minus (* (- 1) x1_plus) x1_minus (* (- 1) x0_plus) x0_minus ) 0) (<= (synthTarget x22_plus x22_minus x20_plus (- 1) x20_minus (* (- 1) x18_plus) x18_minus (* (- 2) x17_plus) (* 2 x17_minus) x14_plus x14_minus (* (- 1) x13_plus) x13_minus (* (- 1) x12_plus) x12_minus x7_plus (* (- 1) x7_minus) x5_plus (* (- 1) x5_minus) x2_plus (* (- 1) x2_minus) (* (- 1) x1_plus) x1_minus ) 0) (<= (synthTarget x22_plus x22_minus (* (- 2) x20_plus) 2 x20_minus x18_plus (* (- 1) x18_minus) x16_plus (* (- 1) x16_minus) x14_plus x14_minus x11_plus (* (- 1) x11_minus) (* (- 1) x10_plus) x10_minus (* (- 1) x5_plus) x5_minus x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus) (* (- 1) x0_plus) x0_minus ) 0) (<= (synthTarget x22_plus x22_minus x21_plus (- 1) x21_minus x20_plus (* (- 1) x20_minus) (* (- 1) x19_plus) x19_minus x16_plus x16_minus x15_plus (* (- 1) x15_minus) x14_plus (* (- 1) x14_minus) (* (- 1) x11_plus) x11_minus x10_plus (* (- 1) x10_minus) (* (- 2) x5_plus) (* 2 x5_minus) x0_plus (* (- 1) x0_minus) ) 0) (<= (+ x24_plus (* (- 1) x24_minus) x21_plus (* (- 1) x21_minus) x19_plus (* (- 1) x19_minus) (* 3 x17_plus) (* (- 3) x17_minus) (* (- 1) x12_plus) x12_minus x10_plus (* (- 1) x10_minus) x6_plus (* (- 1) x6_minus) x2_plus (* (- 1) x2_minus) (* (- 1) x1_plus) x1_minus x0_plus (* (- 1) x0_minus)) 0) (<= (+ x20_plus (* (- 1) x20_minus) (* (- 2) x17_plus) (* 2 x17_minus) (* (- 1) x15_plus) x15_minus x14_plus (* (- 1) x14_minus) x12_plus (* (- 1) x12_minus) (* (- 1) x10_plus) x10_minus x9_plus (* (- 1) x9_minus) x7_plus (* (- 1) x7_minus) x4_plus (* (- 1) x4_minus) x3_plus (* (- 1) x3_minus)) 0) (<= (+ x20_plus (* (- 1) x20_minus) x18_plus (* (- 1) x18_minus) (* (- 1) x16_plus) x16_minus x15_plus (* (- 1) x15_minus) (* (- 1) x14_plus) x14_minus x10_plus (* (- 1) x10_minus) (* (- 1) x8_plus) x8_minus (* (- 1) x6_plus) x6_minus x5_plus (* (- 1) x5_minus) x0_plus (* (- 1) x0_minus)) 0) (<= (+ x22_plus (* (- 1) x22_minus) (* (- 1) x21_plus) x21_minus x20_plus (* (- 1) x20_minus) (* 2 x17_plus) (* (- 2) x17_minus) (* (- 1) x16_plus) x16_minus x12_plus (* (- 1) x12_minus) x10_plus (* (- 1) x10_minus) (* (- 1) x7_plus) x7_minus x5_plus (* (- 1) x5_minus) (* (- 2) x1_plus) (* 2 x1_minus)) 0) (<= (+ (* 2 x23_plus) (* (- 2) x23_minus) (* (- 1) x20_plus) x20_minus x18_plus (* (- 1) x18_minus) x14_plus (* (- 1) x14_minus) (* (- 1) x9_plus) x9_minus (* (- 2) x6_plus) (* 2 x6_minus) (* (- 1) x4_plus) x4_minus (* (- 1) x3_plus) x3_minus x0_plus (* (- 1) x0_minus)) 1) (<= (+ x21_plus (* (- 1) x21_minus) x19_plus (* (- 1) x19_minus) (* (- 1) x18_plus) x18_minus (* 2 x15_plus) (* (- 2) x15_minus) x14_plus (* (- 1) x14_minus) x8_plus (* (- 1) x8_minus) x7_plus (* (- 1) x7_minus) (* (- 1) x3_plus) x3_minus (* (- 1) x0_plus) x0_minus) 0) (<= (+ x23_plus (* (- 1) x23_minus) x18_plus (* (- 1) x18_minus) x16_plus (* (- 1) x16_minus) (* (- 1) x13_plus) x13_minus (* (- 1) x11_plus) x11_minus (* (- 1) x6_plus) x6_minus x3_plus (* (- 1) x3_minus) (* (- 1) x2_plus) x2_minus (* 2 x0_plus) (* (- 2) x0_minus)) 0) (<= (+ x24_plus (* (- 1) x24_minus) x23_plus (* (- 1) x23_minus) x20_plus (* (- 1) x20_minus) (* (- 1) x18_plus) x18_minus x13_plus (* (- 1) x13_minus) (* (- 1) x10_plus) x10_minus (* (- 1) x8_plus) x8_minus x3_plus (* (- 1) x3_minus) (* (- 1) x2_plus) x2_minus) (- 1)) (<= (+ x22_plus (* (- 1) x22_minus) (* (- 1) x20_plus) x20_minus (* (- 1) x16_plus) x16_minus (* (- 1) x7_plus) x7_minus (* (- 1) x5_plus) x5_minus x4_plus (* (- 1) x4_minus) x3_plus (* (- 1) x3_minus) (* (- 1) x1_plus) x1_minus x0_plus (* (- 1) x0_minus)) 0) (<= (+ x21_plus (* (- 1) x21_minus) (* (- 1) x16_plus) x16_minus (* (- 1) x15_plus) x15_minus x14_plus (* (- 1) x14_minus) (* 2 x13_plus) (* (- 2) x13_minus) (* (- 1) x8_plus) x8_minus x7_plus (* (- 1) x7_minus) x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus)) 0) (<= (+ x24_plus (* (- 1) x24_minus) x20_plus (* (- 1) x20_minus) (* 2 x19_plus) (* (- 2) x19_minus) (* (- 1) x18_plus) x18_minus (* (- 1) x12_plus) x12_minus (* (- 1) x8_plus) x8_minus x7_plus (* (- 1) x7_minus) (* (- 1) x4_plus) x4_minus) 0) (<= (+ x22_plus (* (- 1) x22_minus) x17_plus (* (- 1) x17_minus) (* (- 1) x15_plus) x15_minus (* (- 1) x14_plus) x14_minus (* (- 1) x13_plus) x13_minus (* (- 1) x10_plus) x10_minus x3_plus (* (- 1) x3_minus) (* (- 1) x1_plus) x1_minus) (- 1)) (<= (+ x23_plus (* (- 1) x23_minus) (* (- 2) x22_plus) (* 2 x22_minus) x21_plus (* (- 1) x21_minus) x15_plus (* (- 1) x15_minus) (* (- 1) x14_plus) x14_minus (* (- 2) x9_plus) (* 2 x9_minus) (* (- 1) x7_plus) x7_minus (* (- 1) x6_plus) x6_minus) (- 1)) (<= (+ x19_plus (* (- 1) x19_minus) x13_plus (* (- 1) x13_minus) (* (- 1) x12_plus) x12_minus (* (- 1) x11_plus) x11_minus (* (- 2) x10_plus) (* 2 x10_minus) (* (- 1) x9_plus) x9_minus x6_plus (* (- 1) x6_minus) (* (- 1) x5_plus) x5_minus) 0) (<= (+ x22_plus (* (- 1) x22_minus) (* (- 2) x19_plus) (* 2 x19_minus) (* (- 1) x8_plus) x8_minus x7_plus (* (- 1) x7_minus) x4_plus (* (- 1) x4_minus) (* (- 1) x3_plus) x3_minus x1_plus (* (- 1) x1_minus)) 1) (<= (+ x24_plus (* (- 1) x24_minus) (* (- 1) x23_plus) x23_minus x9_plus (* (- 1) x9_minus) x8_plus (* (- 1) x8_minus) x4_plus (* (- 1) x4_minus) (* (- 1) x2_plus) x2_minus) (- 1)) (<= (+ x20_plus (* (- 1) x20_minus) x11_plus (* (- 1) x11_minus) (* (- 1) x9_plus) x9_minus x8_plus (* (- 1) x8_minus) x6_plus (* (- 1) x6_minus) x5_plus (* (- 1) x5_minus)) 0) (<= (+ x19_plus (* (- 1) x19_minus) x17_plus (* (- 1) x17_minus) (* 2 x12_plus) (* (- 2) x12_minus) x9_plus (* (- 1) x9_minus) x3_plus (* (- 1) x3_minus) x2_plus (* (- 1) x2_minus)) (- 1)) (<= (+ x22_plus (* (- 1) x22_minus) (* 2 x14_plus) (* (- 2) x14_minus) (* (- 1) x13_plus) x13_minus (* (- 1) x11_plus) x11_minus x8_plus (* (- 1) x8_minus) x7_plus (* (- 1) x7_minus)) (- 1)) (<= (+ x21_plus (* (- 1) x21_minus) x20_plus (* (- 1) x20_minus) x16_plus (* (- 1) x16_minus) (* (- 1) x15_plus) x15_minus (* (- 1) x10_plus) x10_minus (* (- 1) x5_plus) x5_minus) (- 1)) (<= (+ (* 2 x22_plus) (* (- 2) x22_minus) (* (- 1) x19_plus) x19_minus (* (- 1) x12_plus) x12_minus (* (- 1) x7_plus) x7_minus) (- 1)) (>= (+ x22_plus (* (- 1) x22_minus) (* (- 1) x21_plus) x21_minus (* (- 1) x20_plus) x20_minus x19_plus (* (- 1) x19_minus) x16_plus (* (- 1) x16_minus) (* (- 1) x15_plus) x15_minus (* (- 2) x13_plus) (* 2 x13_minus) x11_plus (* (- 1) x11_minus) (* (- 1) x10_plus) x10_minus x8_plus (* (- 1) x8_minus) (* (- 1) x5_plus) x5_minus (* (- 1) x4_plus) x4_minus) 0) (>= (+ x24_plus (* (- 1) x24_minus) x19_plus (* (- 1) x19_minus) x18_plus (* (- 1) x18_minus) x16_plus (* (- 1) x16_minus) (* (- 1) x15_plus) x15_minus x12_plus (* (- 1) x12_minus) (* 2 x10_plus) (* (- 2) x10_minus) x7_plus (* (- 1) x7_minus) (* (- 1) x5_plus) x5_minus (* (- 1) x3_plus) x3_minus (* (- 1) x0_plus) x0_minus) 0) (>= (+ x21_plus (* (- 1) x21_minus) (* (- 1) x19_plus) x19_minus x16_plus (* (- 1) x16_minus) (* (- 1) x15_plus) x15_minus (* (- 1) x13_plus) x13_minus x7_plus (* (- 1) x7_minus) (* (- 1) x6_plus) x6_minus (* (- 1) x2_plus) x2_minus (* (- 1) x1_plus) x1_minus (* (- 1) x0_plus) x0_minus) 0) (>= (+ x24_plus (* (- 1) x24_minus) x17_plus (* (- 1) x17_minus) (* (- 1) x16_plus) x16_minus x14_plus (* (- 1) x14_minus) x9_plus (* (- 1) x9_minus) (* (- 1) x7_plus) x7_minus x6_plus (* (- 1) x6_minus) x4_plus (* (- 1) x4_minus) x2_plus (* (- 1) x2_minus) x1_plus (* (- 1) x1_minus)) 1) (>= (+ x19_plus (* (- 1) x19_minus) x18_plus (* (- 1) x18_minus) x14_plus (* (- 1) x14_minus) (* (- 1) x11_plus) x11_minus x8_plus (* (- 1) x8_minus) x7_plus (* (- 1) x7_minus) (* (- 1) x6_plus) x6_minus x4_plus (* (- 1) x4_minus) (* (- 1) x1_plus) x1_minus (* (- 1) x0_plus) x0_minus) 1) (>= (+ x23_plus (* (- 1) x23_minus) (* (- 1) x22_plus) x22_minus x21_plus (* (- 1) x21_minus) (* (- 1) x19_plus) x19_minus x12_plus (* (- 1) x12_minus) (* (- 1) x11_plus) x11_minus (* (- 1) x8_plus) x8_minus x5_plus (* (- 1) x5_minus) x3_plus (* (- 1) x3_minus) x0_plus (* (- 1) x0_minus)) 0) (>= (+ x22_plus (* (- 1) x22_minus) x16_plus (* (- 1) x16_minus) x15_plus (* (- 1) x15_minus) (* 2 x14_plus) (* (- 2) x14_minus) (* (- 1) x12_plus) x12_minus x10_plus (* (- 1) x10_minus) x7_plus (* (- 1) x7_minus) x3_plus (* (- 1) x3_minus) x1_plus (* (- 1) x1_minus) (* (- 1) x0_plus) x0_minus) 1) (>= (+ x24_plus (* (- 1) x24_minus) (* (- 1) x23_plus) x23_minus (* (- 1) x20_plus) x20_minus (* (- 1) x17_plus) x17_minus (* (- 2) x15_plus) (* 2 x15_minus) x12_plus (* (- 1) x12_minus) (* (- 1) x10_plus) x10_minus x3_plus (* (- 1) x3_minus) (* (- 2) x1_plus) (* 2 x1_minus)) 1) (>= (+ x20_plus (* (- 1) x20_minus) (* 2 x18_plus) (* (- 2) x18_minus) x15_plus (* (- 1) x15_minus) (* (- 1) x14_plus) x14_minus (* (- 1) x10_plus) x10_minus (* 2 x8_plus) (* (- 2) x8_minus) (* (- 1) x5_plus) x5_minus x1_plus (* (- 1) x1_minus) (* (- 1) x0_plus) x0_minus) 0) (>= (+ x22_plus (* (- 1) x22_minus) (* (- 1) x20_plus) x20_minus x13_plus (* (- 1) x13_minus) (* (- 1) x12_plus) x12_minus (* (- 2) x10_plus) (* 2 x10_minus) (* (- 2) x8_plus) (* 2 x8_minus) (* (- 3) x7_plus) (* 3 x7_minus) x4_plus (* (- 1) x4_minus) (* (- 1) x3_plus) x3_minus) 0) (>= (+ x22_plus (* (- 1) x22_minus) x18_plus (* (- 1) x18_minus) (* (- 2) x16_plus) (* 2 x16_minus) x15_plus (* (- 1) x15_minus) x14_plus (* (- 1) x14_minus) (* (- 1) x12_plus) x12_minus (* (- 1) x8_plus) x8_minus (* (- 1) x7_plus) x7_minus x5_plus (* (- 1) x5_minus)) 1) (>= (+ x24_plus (* (- 1) x24_minus) x23_plus (* (- 1) x23_minus) x16_plus (* (- 1) x16_minus) (* (- 1) x13_plus) x13_minus (* (- 2) x11_plus) (* 2 x11_minus) (* 2 x10_plus) (* (- 2) x10_minus) (* (- 1) x7_plus) x7_minus (* (- 1) x1_plus) x1_minus x0_plus (* (- 1) x0_minus)) (- 1)) (>= (+ (* 2 x21_plus) (* (- 2) x21_minus) (* (- 1) x20_plus) x20_minus x18_plus (* (- 1) x18_minus) (* (- 1) x16_plus) x16_minus x9_plus (* (- 1) x9_minus) (* (- 1) x5_plus) x5_minus (* (- 1) x4_plus) x4_minus (* (- 1) x1_plus) x1_minus x0_plus (* (- 1) x0_minus)) 0) (>= (+ x24_plus (* (- 1) x24_minus) (* (- 1) x18_plus) x18_minus (* (- 1) x17_plus) x17_minus (* (- 1) x16_plus) x16_minus (* (- 1) x12_plus) x12_minus x11_plus (* (- 1) x11_minus) (* 3 x9_plus) (* (- 3) x9_minus) (* (- 1) x8_plus) x8_minus (* (- 1) x5_plus) x5_minus) (- 1)) (>= (+ x17_plus (* (- 1) x17_minus) (* (- 1) x15_plus) x15_minus (* (- 1) x13_plus) x13_minus x12_plus (* (- 1) x12_minus) (* (- 1) x11_plus) x11_minus (* 2 x10_plus) (* (- 2) x10_minus) x9_plus (* (- 1) x9_minus) (* (- 1) x4_plus) x4_minus (* (- 2) x1_plus) (* 2 x1_minus)) (- 1)) (>= (+ (* 2 x21_plus) (* (- 2) x21_minus) (* (- 1) x19_plus) x19_minus (* (- 1) x18_plus) x18_minus (* (- 1) x14_plus) x14_minus (* (- 1) x12_plus) x12_minus (* (- 1) x10_plus) x10_minus (* (- 1) x8_plus) x8_minus (* (- 1) x0_plus) x0_minus) 0) (>= (+ x23_plus (* (- 1) x23_minus) (* (- 1) x22_plus) x22_minus (* (- 1) x20_plus) x20_minus x13_plus (* (- 1) x13_minus) (* (- 1) x11_plus) x11_minus x10_plus (* (- 1) x10_minus) (* (- 1) x3_plus) x3_minus (* (- 1) x1_plus) x1_minus) 0) (>= (+ x24_plus (* (- 1) x24_minus) (* (- 1) x22_plus) x22_minus (* (- 2) x21_plus) (* 2 x21_minus) (* (- 2) x18_plus) (* 2 x18_minus) (* (- 1) x13_plus) x13_minus x10_plus (* (- 1) x10_minus) (* (- 1) x9_plus) x9_minus (* (- 1) x5_plus) x5_minus) 0) (>= (+ x22_plus (* (- 1) x22_minus) (* (- 1) x20_plus) x20_minus (* (- 1) x18_plus) x18_minus x11_plus (* (- 1) x11_minus) (* (- 1) x10_plus) x10_minus (* (- 1) x9_plus) x9_minus (* (- 1) x6_plus) x6_minus (* (- 1) x3_plus) x3_minus) (- 1)) (>= (+ x23_plus (* (- 1) x23_minus) x21_plus (* (- 1) x21_minus) (* 2 x20_plus) (* (- 2) x20_minus) x18_plus (* (- 1) x18_minus) (* (- 1) x16_plus) x16_minus x9_plus (* (- 1) x9_minus) (* 2 x4_plus) (* (- 2) x4_minus) (* (- 1) x0_plus) x0_minus) (- 1)) (>= (+ (* 2 x21_plus) (* (- 2) x21_minus) (* (- 1) x20_plus) x20_minus x11_plus (* (- 1) x11_minus) (* (- 1) x10_plus) x10_minus x9_plus (* (- 1) x9_minus) (* (- 1) x7_plus) x7_minus (* 2 x0_plus) (* (- 2) x0_minus)) 0) (>= (+ x24_plus (* (- 1) x24_minus) x23_plus (* (- 1) x23_minus) x22_plus (* (- 1) x22_minus) x18_plus (* (- 1) x18_minus) (* (- 1) x16_plus) x16_minus (* (- 1) x15_plus) x15_minus x9_plus (* (- 1) x9_minus)) (- 1)) (>= (+ x22_plus (* (- 1) x22_minus) (* (- 1) x21_plus) x21_minus (* (- 1) x17_plus) x17_minus (* (- 1) x14_plus) x14_minus x12_plus (* (- 1) x12_minus) (* 3 x5_plus) (* (- 3) x5_minus) x2_plus (* (- 1) x2_minus)) 0) (>= (+ x23_plus (* (- 1) x23_minus) (* (- 2) x17_plus) (* 2 x17_minus) (* (- 2) x5_plus) (* 2 x5_minus) (* (- 1) x3_plus) x3_minus (* (- 1) x2_plus) x2_minus) 0))))
(check-synth)
