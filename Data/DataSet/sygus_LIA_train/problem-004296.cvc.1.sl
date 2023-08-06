; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ 0 < 0 ? 1 : 0) + (true ∧ -2 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + (-2 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -1 < 0 ? 1 : 0)) + (true ∧ -2 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_4489677228215862572 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) : (¬true ? 0 : (¬false ? 1 : 1)))) > 0 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) > 0 ? 128 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 1 : 1))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) : (¬true ? 0 : (¬false ? 0 : 0)))) > 0 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) > 0 ? 32 : 0) + (((¬true ? 0 : (¬false ? 1 : 0)) > 0 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 1 : 1))) > 0 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) : (¬true ? 0 : (¬false ? 0 : 0)))) > 0 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) > 0 ? 2 : 0) + ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 1 : 1))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) : (¬true ? 0 : (¬false ? 1 : 0)))) > 0 ? 1 : 0)))))))) = 281 ∧ var_1028932139476111945 < 0 : var_18107809400526282562)) : var_14360617993772491416) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_4489677228215862572 Bool)(var_1028932139476111945 Int)(var_18107809400526282562 Bool)(var_14360617993772491416 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_1028932139476111945 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_4489677228215862572 var_18107809400526282562 var_14360617993772491416 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 (- 1)) 1) (- (synthTarget false 0 false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) (- 4) (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
