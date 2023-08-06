; Solution: -1 + (var_16521923926393859218 ? var_1967175447749578505 : (var_1174442341040447355 ? var_8882230431765617199 : var_5570483012646670982))

(set-logic LIA)
(declare-var DISJ_W_S1_R_S1 Bool)

(declare-var DISJ_W_S1_R_S2 Bool)

(declare-var DISJ_W_S1_W_S2 Bool)

(declare-var DISJ_W_S2_R_S1 Bool)

(declare-var DISJ_W_S2_R_S2 Bool)

(declare-var R_S1_V1 Bool)

(declare-var R_S1_V2 Bool)

(declare-var R_S1_V3 Bool)

(declare-var R_S1_V4 Bool)

(declare-var R_S1_V5 Bool)

(declare-var R_S2_V1 Bool)

(declare-var R_S2_V2 Bool)

(declare-var R_S2_V3 Bool)

(declare-var R_S2_V4 Bool)

(declare-var R_S2_V5 Bool)

(declare-var W_S1_V1 Bool)

(declare-var W_S1_V2 Bool)

(declare-var W_S1_V3 Bool)

(declare-var W_S1_V4 Bool)

(declare-var W_S1_V5 Bool)

(declare-var W_S2_V1 Bool)

(declare-var W_S2_V2 Bool)

(declare-var W_S2_V3 Bool)

(declare-var W_S2_V4 Bool)

(declare-var W_S2_V5 Bool)

(synth-fun synthTarget((var_16521923926393859218 Bool)(var_1967175447749578505 Int)(var_1174442341040447355 Bool)(var_8882230431765617199 Int)(var_5570483012646670982 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_1967175447749578505 var_8882230431765617199 var_5570483012646670982 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_16521923926393859218 var_1174442341040447355 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and (not W_S2_V2) (not W_S2_V1) W_S1_V3 W_S2_V4 (= DISJ_W_S1_R_S1 (not (or (and W_S1_V4 R_S1_V4) (and W_S1_V5 R_S1_V5) (and W_S1_V2 R_S1_V2) R_S1_V3 (and W_S1_V1 R_S1_V1)))) (= DISJ_W_S1_R_S2 (not (or (and W_S1_V4 R_S2_V4) (and W_S1_V5 R_S2_V5) (and W_S1_V2 R_S2_V2) R_S2_V3 (and W_S1_V1 R_S2_V1)))) (= DISJ_W_S1_W_S2 (not (or W_S1_V4 (and W_S1_V5 W_S2_V5) W_S2_V3))) (= DISJ_W_S2_R_S1 (not (or R_S1_V4 (and W_S2_V5 R_S1_V5) (and W_S2_V3 R_S1_V3)))) (= DISJ_W_S2_R_S2 (not (or R_S2_V4 (and W_S2_V5 R_S2_V5) (and W_S2_V3 R_S2_V3)))) (forall ((V4_0 Int) (V5_0 Int) (V2_0 Int) (V3_0 Int) (V1_0 Int) (MW_S1_V4 Bool) (MW_S1_V5 Bool) (MW_S1_V2 Bool) (MW_S1_V3 Bool) (MW_S1_V1 Bool) (MW_S2_V4 Bool) (MW_S2_V5 Bool) (MW_S2_V2 Bool) (MW_S2_V3 Bool) (MW_S2_V1 Bool) (S1_V4_!400 Int) (S1_V4_!415 Int) (S2_V4_!405 Int) (S2_V4_!410 Int) (S2_V5_!406 Int) (S2_V5_!411 Int) (S1_V1_!404 Int) (S1_V1_!419 Int) (S1_V3_!403 Int) (S1_V3_!418 Int) (S1_V2_!402 Int) (S1_V2_!417 Int) (S2_V1_!409 Int) (S2_V1_!414 Int) (S2_V2_!407 Int) (S2_V2_!412 Int) (S2_V3_!408 Int) (S2_V3_!413 Int) (S1_V5_!401 Int) (S1_V5_!416 Int) )(or (not (and (or (not (and (or (not R_S1_V4) (= (ite MW_S2_V4 S2_V4_!410 V4_0) V4_0)) (or (not R_S1_V5) (= (ite MW_S2_V5 S2_V5_!411 V5_0) V5_0)) (or (not R_S1_V2) (= (ite MW_S2_V2 S2_V2_!412 V2_0) V2_0)) (or (not R_S1_V3) (= (ite MW_S2_V3 S2_V3_!413 V3_0) V3_0)) (or (not R_S1_V1) (= (ite MW_S2_V1 S2_V1_!414 V1_0) V1_0)))) (= S1_V4_!415 S1_V4_!400)) (or (not (and (or (not R_S2_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!400 V4_0))) (or (not R_S2_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!401 V5_0))) (or (not R_S2_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!402 V2_0))) (or (not R_S2_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!403 V3_0))) (or (not R_S2_V1) (= V1_0 (ite MW_S1_V1 S1_V1_!404 V1_0))))) (= S2_V4_!410 S2_V4_!405)) (or (not (and (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!400 V4_0) V4_0)) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!401 V5_0) V5_0)) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!402 V2_0) V2_0)) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!403 V3_0) V3_0)) (or (not R_S2_V1) (= (ite MW_S1_V1 S1_V1_!404 V1_0) V1_0)))) (= S2_V5_!406 S2_V5_!411)) (or (not (and (or (not R_S1_V4) (= (ite MW_S2_V4 S2_V4_!410 V4_0) V4_0)) (or (not R_S1_V5) (= (ite MW_S2_V5 S2_V5_!411 V5_0) V5_0)) (or (not R_S1_V2) (= (ite MW_S2_V2 S2_V2_!412 V2_0) V2_0)) (or (not R_S1_V3) (= (ite MW_S2_V3 S2_V3_!413 V3_0) V3_0)) (or (not R_S1_V1) (= (ite MW_S2_V1 S2_V1_!414 V1_0) V1_0)))) (= S1_V1_!419 S1_V1_!404)) (or (not (and (or (not R_S1_V4) (= (ite MW_S2_V4 S2_V4_!410 V4_0) V4_0)) (or (not R_S1_V5) (= (ite MW_S2_V5 S2_V5_!411 V5_0) V5_0)) (or (not R_S1_V2) (= (ite MW_S2_V2 S2_V2_!412 V2_0) V2_0)) (or (not R_S1_V3) (= (ite MW_S2_V3 S2_V3_!413 V3_0) V3_0)) (or (not R_S1_V1) (= (ite MW_S2_V1 S2_V1_!414 V1_0) V1_0)))) (= S1_V3_!418 S1_V3_!403)) (or (not (and (or (not R_S1_V4) (= (ite MW_S2_V4 S2_V4_!410 V4_0) V4_0)) (or (not R_S1_V5) (= (ite MW_S2_V5 S2_V5_!411 V5_0) V5_0)) (or (not R_S1_V2) (= (ite MW_S2_V2 S2_V2_!412 V2_0) V2_0)) (or (not R_S1_V3) (= (ite MW_S2_V3 S2_V3_!413 V3_0) V3_0)) (or (not R_S1_V1) (= (ite MW_S2_V1 S2_V1_!414 V1_0) V1_0)))) (= S1_V2_!417 S1_V2_!402)) (or (not (and (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!400 V4_0) V4_0)) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!401 V5_0) V5_0)) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!402 V2_0) V2_0)) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!403 V3_0) V3_0)) (or (not R_S2_V1) (= (ite MW_S1_V1 S1_V1_!404 V1_0) V1_0)))) (= S2_V1_!409 S2_V1_!414)) (or (not (and (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!400 V4_0) V4_0)) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!401 V5_0) V5_0)) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!402 V2_0) V2_0)) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!403 V3_0) V3_0)) (or (not R_S2_V1) (= (ite MW_S1_V1 S1_V1_!404 V1_0) V1_0)))) (= S2_V2_!407 S2_V2_!412)) (or (not (and (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!400 V4_0) V4_0)) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!401 V5_0) V5_0)) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!402 V2_0) V2_0)) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!403 V3_0) V3_0)) (or (not R_S2_V1) (= (ite MW_S1_V1 S1_V1_!404 V1_0) V1_0)))) (= S2_V3_!408 S2_V3_!413)) (or (not (and (or (not R_S1_V4) (= (ite MW_S2_V4 S2_V4_!410 V4_0) V4_0)) (or (not R_S1_V5) (= (ite MW_S2_V5 S2_V5_!411 V5_0) V5_0)) (or (not R_S1_V2) (= (ite MW_S2_V2 S2_V2_!412 V2_0) V2_0)) (or (not R_S1_V3) (= (ite MW_S2_V3 S2_V3_!413 V3_0) V3_0)) (or (not R_S1_V1) (= (ite MW_S2_V1 S2_V1_!414 V1_0) V1_0)))) (= S1_V5_!416 S1_V5_!401)) (or (not MW_S1_V4) W_S1_V4) (or (not MW_S1_V5) W_S1_V5) (or (not MW_S1_V2) W_S1_V2) (or (not MW_S1_V1) W_S1_V1) (or (not MW_S2_V5) W_S2_V5) (not MW_S2_V2) (or (not MW_S2_V3) W_S2_V3) (not MW_S2_V1))) (not (and (not (<= V2_0 V1_0)) (>= (ite MW_S2_V1 S2_V1_!409 (ite MW_S1_V1 S1_V1_!404 V1_0)) (synthTarget MW_S2_V2 S2_V2_!407 MW_S1_V2 S1_V2_!402 V2_0 )) (not (<= (ite MW_S2_V2 S2_V2_!412 V2_0) (ite MW_S2_V1 S2_V1_!414 V1_0))) (>= (ite MW_S1_V1 S1_V1_!419 (ite MW_S2_V1 S2_V1_!414 V1_0)) (synthTarget MW_S1_V2 S1_V2_!417 MW_S2_V2 S2_V2_!412 V2_0 )))) (and (= (ite MW_S2_V4 S2_V4_!405 (ite MW_S1_V4 S1_V4_!400 V4_0)) (ite MW_S1_V4 S1_V4_!415 (ite MW_S2_V4 S2_V4_!410 V4_0))) (= (ite MW_S2_V5 S2_V5_!406 (ite MW_S1_V5 S1_V5_!401 V5_0)) (ite MW_S1_V5 S1_V5_!416 (ite MW_S2_V5 S2_V5_!411 V5_0))) (= (ite MW_S2_V2 S2_V2_!407 (ite MW_S1_V2 S1_V2_!402 V2_0)) (ite MW_S1_V2 S1_V2_!417 (ite MW_S2_V2 S2_V2_!412 V2_0))) (= (ite MW_S2_V3 S2_V3_!408 (ite MW_S1_V3 S1_V3_!403 V3_0)) (ite MW_S1_V3 S1_V3_!418 (ite MW_S2_V3 S2_V3_!413 V3_0))) (= (ite MW_S2_V1 S2_V1_!409 (ite MW_S1_V1 S1_V1_!404 V1_0)) (ite MW_S1_V1 S1_V1_!419 (ite MW_S2_V1 S2_V1_!414 V1_0))))))) (not (and DISJ_W_S1_R_S2 DISJ_W_S1_W_S2 DISJ_W_S2_R_S1)))))
(check-synth)
