; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ -1 < 0 ? 1 : 0) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ 0 < 0 ? 1 : 0)) + (1 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -4 < 0 ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_10326572165479639273 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 1 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 2 : 2))) : (¬true ? 0 : (¬true ? 2 : 0)))) > 0 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 2 : 2))) > 0 ? 128 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 0 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 2 : 2))) : (¬true ? 0 : (¬true ? 0 : 2)))) > 0 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 1 : 0))) > 0 ? 32 : 0) + (((¬true ? 0 : (¬true ? 0 : 1)) > 0 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 0 : 0))) > 0 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 1 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 0 : 0))) : (¬true ? 0 : (¬true ? 0 : 1)))) > 0 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 0 : 0))) > 0 ? 2 : 0) + ((¬(¬true) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 0 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬true ? 0 : 1)) : (¬true ? 0 : (¬true ? 0 : 0))) : (¬true ? 0 : (¬true ? 0 : 0)))) > 0 ? 1 : 0)))))))) = 212 ∧ var_12774048137010983366 < 0 : var_379211878593626333)) : var_15655337818203252568) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_10326572165479639273 Bool)(var_12774048137010983366 Int)(var_379211878593626333 Bool)(var_15655337818203252568 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_12774048137010983366 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_10326572165479639273 var_379211878593626333 var_15655337818203252568 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 0) 1) (- (synthTarget false (- 16) false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) 15 (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
