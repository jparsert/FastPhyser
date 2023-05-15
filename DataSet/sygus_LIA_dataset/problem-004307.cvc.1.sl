; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ 0 < 0 ? 1 : 0) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + (-1 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -1 < 0 ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_3981581395850015029 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 6))) : (¬true ? 0 : (¬true ? 6 : 6)))) > 6 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 6))) > 6 ? 128 : 0) + (((¬(¬true) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 6))) : (¬true ? 0 : (¬true ? 7 : 6)))) > 6 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) > 6 ? 32 : 0) + (((¬true ? 0 : (¬true ? 6 : 6)) > 6 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬true ? 0 : (¬true ? 7 : 0)))) > 6 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) > 6 ? 2 : 0) + ((¬(¬true) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 6)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬true ? 0 : (¬true ? 0 : 6)))) > 6 ? 1 : 0)))))))) = 34 ∧ var_8954929431859008397 < 0 : var_666977060751430357)) : var_15082041611406118800) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_3981581395850015029 Bool)(var_8954929431859008397 Int)(var_666977060751430357 Bool)(var_15082041611406118800 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_8954929431859008397 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_3981581395850015029 var_666977060751430357 var_15082041611406118800 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 (- 1)) 1) (- (synthTarget false 1 false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) (- 2) (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
