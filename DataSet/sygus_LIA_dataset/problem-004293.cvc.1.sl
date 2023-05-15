; smt-lib-version 2.6
; source 
;    Sequential equivalence checking.
;    Calypto Design Systems, Inc. <www.calypto.com>
;  
; category industrial
; status sat
; Solution: ((¬(¬(¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? true : false)) : false) : false)) ∨ ¬((¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? false : (¬false ? ¬((¬(¬false) ? 0 : (((((((((true ∧ true) ∧ 3 < 0 ? 1 : 0) + (true ∧ -2 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) + (true ∧ -4 < 0 ? 1 : 0)) + (-2 < 0 ? 1 : 0)) + (true ∧ true ? 1 : 0)) + ((true ∧ true) ∧ -1 < 0 ? 1 : 0)) + (true ∧ -1 < 0 ? 1 : 0)) + ((true ∧ true) ∧ true ? 1 : 0)) = 0) : false)) : false) : false)))) ? false : (¬(¬true) ? (¬((¬true ? false : (¬true ? (true ∨ false) ∨ false : false))) ? (¬true ? var_306306963069904303 : (¬false ? ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) : (¬true ? 0 : (¬false ? 1 : 1)))) > 0 ? 256 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) > 0 ? 128 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) : (¬true ? 0 : (¬false ? 0 : 0)))) > 0 ? 64 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) > 0 ? 32 : 0) + (((¬true ? 0 : (¬false ? 1 : 0)) > 0 ? 16 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) > 0 ? 8 : 0) + (((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 0))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 1 : 0))) : (¬true ? 0 : (¬false ? 0 : 7)))) > 0 ? 4 : 0) + (((¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 1 : 0))) > 0 ? 2 : 0) + ((¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 0 : 1))) : (¬(¬false) ? (¬(¬false) ? (¬true ? 0 : (¬false ? 1 : 0)) : (¬true ? 0 : (¬false ? 1 : 0))) : (¬true ? 0 : (¬false ? 1 : 1)))) > 0 ? 1 : 0)))))))) = 275 ∧ var_13997246930095758359 < 0 : var_6215202220702310162)) : var_11765212417313384445) : false)) ? 1 : 0)

(set-logic LIA)
(synth-fun synthTarget((var_306306963069904303 Bool)(var_13997246930095758359 Int)(var_6215202220702310162 Bool)(var_11765212417313384445 Bool)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_13997246930095758359 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_306306963069904303 var_6215202220702310162 var_11765212417313384445 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (= (+ (* 2 0) 1) (- (synthTarget false (- 2) false false ) (synthTarget (ite (not (not (or (not false) (not false)))) false false) 0 (ite (not (not (or (not false) (not false)))) false false) (ite (not (not (or (not false) (not false)))) false false) ))))
(check-synth)
