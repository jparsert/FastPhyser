; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ 0 < 0 ? 1 : 0) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + (-1 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -1 < 0 ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_13566344688716399949 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 6))) : (¬true ? 0 : (¬true ? 6 : 6)))) > 6 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 6))) > 6 ? 128 : 0) + (((¬(¬true) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 6))) : (¬true ? 0 : (¬true ? 7 : 6)))) > 6 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) > 6 ? 32 : 0) + (((¬true ? 0 : (¬true ? 6 : 6)) > 6 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬true ? 0 : (¬true ? 7 : 7)))) > 6 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) > 6 ? 2 : 0) + ((¬(¬true) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬true ? 0 : (¬true ? 0 : 6)))) > 6 ? 1 : 0)))))))) = 38 ∧ var_16880984033595695219 < 0 : var_597161281224806947)) : var_12776536958281253064) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_13566344688716399949 Bool)(var_16880984033595695219 Int)(var_597161281224806947 Bool)(var_12776536958281253064 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_16880984033595695219 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_13566344688716399949 var_597161281224806947 var_12776536958281253064 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 (- 1)) 1) (- (synthTarget false 1 false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) (- 2) (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
