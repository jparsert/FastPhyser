; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ 0 < 0 ? 1 : 0) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + (-1 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -1 < 0 ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_15370158262631214652 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 7))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬true ? 0 : (¬true ? 6 : 6)))) > 6 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 128 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬true ? 0 : (¬true ? 7 : 7)))) > 6 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 7))) > 6 ? 32 : 0) + (((¬true ? 0 : (¬true ? 6 : 7)) > 6 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 7))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 6 : 6))) : (¬true ? 0 : (¬true ? 6 : 7)))) > 6 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 6 : 6))) > 6 ? 2 : 0) + ((¬(¬true) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 6 : 6))) : (¬true ? 0 : (¬true ? 0 : 6)))) > 6 ? 1 : 0)))))))) = 116 ∧ var_13855311877683137287 < 0 : var_2831866106716033627)) : var_5134328683259643386) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_15370158262631214652 Bool)(var_13855311877683137287 Int)(var_2831866106716033627 Bool)(var_5134328683259643386 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_13855311877683137287 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_15370158262631214652 var_2831866106716033627 var_5134328683259643386 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 (- 1)) 1) (- (synthTarget false 7 false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) (- 8) (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
