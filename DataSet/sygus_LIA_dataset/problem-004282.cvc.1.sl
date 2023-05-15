; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ -1 < 0 ? 1 : 0) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ 3 < 0 ? 1 : 0)) + (-1 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -1 < 0 ? 1 : 0)) + (true ∧ -2 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_452260387770108900 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬true ? 0 : (¬true ? 7 : 7)))) > 6 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 6 : 7))) > 6 ? 128 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 6 : 7))) : (¬true ? 0 : (¬true ? 7 : 6)))) > 6 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 32 : 0) + (((¬true ? 0 : (¬true ? 6 : 7)) > 6 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬true ? 0 : (¬true ? 6 : 6)))) > 6 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) > 6 ? 2 : 0) + ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 6 : 7)) : (¬true ? 0 : (¬true ? 7 : 6))) : (¬true ? 0 : (¬true ? 0 : 7)))) > 6 ? 1 : 0)))))))) = 401 ∧ var_10110506673779991158 < 0 : var_11912012337411364736)) : var_1174342711692086951) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_452260387770108900 Bool)(var_10110506673779991158 Int)(var_11912012337411364736 Bool)(var_1174342711692086951 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_10110506673779991158 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_452260387770108900 var_11912012337411364736 var_1174342711692086951 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 0) 1) (- (synthTarget false (- 1) false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) 0 (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
