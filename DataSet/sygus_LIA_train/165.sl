; Solution: (var_17025705680091504270 ? var_9314520268859297702 : 1 + (var_4557667827346072218 ? var_3481053914857008366 : var_4846371129286175358))

(set-logic LIA)
(declare-var DISJ_W_S1_R_B1 Bool)

(declare-var DISJ_W_S1_R_S1 Bool)

(declare-var DISJ_W_S1_R_S2 Bool)

(declare-var DISJ_W_S1_W_S2 Bool)

(declare-var DISJ_W_S2_R_B1 Bool)

(declare-var DISJ_W_S2_R_S1 Bool)

(declare-var DISJ_W_S2_R_S2 Bool)

(declare-var R_B1_V1 Bool)

(declare-var R_B1_V2 Bool)

(declare-var R_B1_V3 Bool)

(declare-var R_B1_V4 Bool)

(declare-var R_B1_V5 Bool)

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

(synth-fun synthTarget((var_17025705680091504270 Bool)(var_9314520268859297702 Int)(var_4557667827346072218 Bool)(var_3481053914857008366 Int)(var_4846371129286175358 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_9314520268859297702 var_3481053914857008366 var_4846371129286175358 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_17025705680091504270 var_4557667827346072218 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and W_S1_V3 W_S2_V4 (= DISJ_W_S1_R_S1 (not (or (and W_S1_V1 R_S1_V1) R_S1_V3 (and W_S1_V2 R_S1_V2) (and W_S1_V5 R_S1_V5) (and W_S1_V4 R_S1_V4)))) (= DISJ_W_S1_R_S2 (not (or (and W_S1_V1 R_S2_V1) R_S2_V3 (and W_S1_V2 R_S2_V2) (and W_S1_V5 R_S2_V5) (and W_S1_V4 R_S2_V4)))) (= DISJ_W_S1_R_B1 (not (or (and W_S1_V1 R_B1_V1) R_B1_V3 (and W_S1_V2 R_B1_V2) (and W_S1_V5 R_B1_V5) (and W_S1_V4 R_B1_V4)))) (= DISJ_W_S1_W_S2 (not (or (and W_S1_V1 W_S2_V1) W_S2_V3 (and W_S1_V2 W_S2_V2) (and W_S1_V5 W_S2_V5) W_S1_V4))) (= DISJ_W_S2_R_S1 (not (or (and W_S2_V1 R_S1_V1) (and W_S2_V3 R_S1_V3) (and W_S2_V2 R_S1_V2) (and W_S2_V5 R_S1_V5) R_S1_V4))) (= DISJ_W_S2_R_S2 (not (or (and W_S2_V1 R_S2_V1) (and W_S2_V3 R_S2_V3) (and W_S2_V2 R_S2_V2) (and W_S2_V5 R_S2_V5) R_S2_V4))) (= DISJ_W_S2_R_B1 (not (or (and W_S2_V1 R_B1_V1) (and W_S2_V3 R_B1_V3) (and W_S2_V2 R_B1_V2) (and W_S2_V5 R_B1_V5) R_B1_V4))) (forall ((V1_0 Int) (V3_0 Int) (V2_0 Int) (V5_0 Int) (V4_0 Int) (MW_S1_V1 Bool) (MW_S1_V3 Bool) (MW_S1_V2 Bool) (MW_S1_V5 Bool) (MW_S1_V4 Bool) (MW_S2_V1 Bool) (MW_S2_V3 Bool) (MW_S2_V2 Bool) (MW_S2_V5 Bool) (MW_S2_V4 Bool) (S2_V4_!277 Int) (S2_V4_!289 Int) (S2_V4_!294 Int) (B1_!272 Bool) (B1_!278 Bool) (B1_!284 Bool) (S2_V5_!276 Int) (S2_V5_!288 Int) (S2_V5_!293 Int) (S1_V3_!280 Int) (S1_V2_!281 Int) (S1_V1_!279 Int) (S1_V5_!282 Int) (S1_V4_!283 Int) (S2_V1_!273 Int) (S2_V1_!285 Int) (S2_V1_!290 Int) (S2_V2_!275 Int) (S2_V2_!287 Int) (S2_V2_!292 Int) (S2_V3_!274 Int) (S2_V3_!286 Int) (S2_V3_!291 Int) )(or (not (and (= S2_V4_!289 S2_V4_!277) (or (not (and (or (not R_S2_V1) (= V1_0 (+ 1 (ite MW_S2_V1 S2_V1_!285 V1_0)))) (or (not R_S2_V3) (= V3_0 (ite MW_S2_V3 S2_V3_!286 V3_0))) (or (not R_S2_V2) (= V2_0 (ite MW_S2_V2 S2_V2_!287 V2_0))) (or (not R_S2_V5) (= V5_0 (ite MW_S2_V5 S2_V5_!288 V5_0))) (or (not R_S2_V4) (= V4_0 (ite MW_S2_V4 S2_V4_!289 V4_0))))) (= S2_V4_!289 S2_V4_!294)) (or (not (and (or (not R_S2_V1) (= (ite MW_S2_V1 S2_V1_!285 V1_0) (+ (- 1) V1_0))) (or (not R_S2_V3) (= (ite MW_S2_V3 S2_V3_!286 V3_0) V3_0)) (or (not R_S2_V2) (= (ite MW_S2_V2 S2_V2_!287 V2_0) V2_0)) (or (not R_S2_V5) (= (ite MW_S2_V5 S2_V5_!288 V5_0) V5_0)) (or (not R_S2_V4) (= (ite MW_S2_V4 S2_V4_!289 V4_0) V4_0)))) (= S2_V4_!294 S2_V4_!277)) (= B1_!272 B1_!284) (or (not (and (or (not R_B1_V1) (= (ite MW_S2_V1 S2_V1_!273 V1_0) (+ (- 1) V1_0))) (or (not R_B1_V3) (= (ite MW_S2_V3 S2_V3_!274 V3_0) V3_0)) (or (not R_B1_V2) (= (ite MW_S2_V2 S2_V2_!275 V2_0) V2_0)) (or (not R_B1_V5) (= (ite MW_S2_V5 S2_V5_!276 V5_0) V5_0)) (or (not R_B1_V4) (= (ite MW_S2_V4 S2_V4_!277 V4_0) V4_0)))) (= B1_!278 B1_!272)) (or (not (and (or (not R_B1_V1) (= (ite MW_S2_V1 S2_V1_!273 V1_0) (+ (- 1) V1_0))) (or (not R_B1_V3) (= (ite MW_S2_V3 S2_V3_!274 V3_0) V3_0)) (or (not R_B1_V2) (= (ite MW_S2_V2 S2_V2_!275 V2_0) V2_0)) (or (not R_B1_V5) (= (ite MW_S2_V5 S2_V5_!276 V5_0) V5_0)) (or (not R_B1_V4) (= (ite MW_S2_V4 S2_V4_!277 V4_0) V4_0)))) (= B1_!278 B1_!284)) (= S2_V5_!276 S2_V5_!288) (or (not (and (or (not R_S2_V1) (= (ite MW_S2_V1 S2_V1_!285 V1_0) (+ (- 1) V1_0))) (or (not R_S2_V3) (= (ite MW_S2_V3 S2_V3_!286 V3_0) V3_0)) (or (not R_S2_V2) (= (ite MW_S2_V2 S2_V2_!287 V2_0) V2_0)) (or (not R_S2_V5) (= (ite MW_S2_V5 S2_V5_!288 V5_0) V5_0)) (or (not R_S2_V4) (= (ite MW_S2_V4 S2_V4_!289 V4_0) V4_0)))) (= S2_V5_!293 S2_V5_!276)) (or (not (and (or (not R_S2_V1) (= (ite MW_S2_V1 S2_V1_!285 V1_0) (+ (- 1) V1_0))) (or (not R_S2_V3) (= (ite MW_S2_V3 S2_V3_!286 V3_0) V3_0)) (or (not R_S2_V2) (= (ite MW_S2_V2 S2_V2_!287 V2_0) V2_0)) (or (not R_S2_V5) (= (ite MW_S2_V5 S2_V5_!288 V5_0) V5_0)) (or (not R_S2_V4) (= (ite MW_S2_V4 S2_V4_!289 V4_0) V4_0)))) (= S2_V5_!293 S2_V5_!288)) (= S2_V1_!285 S2_V1_!273) (or (not (and (or (not R_S2_V1) (= V1_0 (+ 1 (ite MW_S2_V1 S2_V1_!285 V1_0)))) (or (not R_S2_V3) (= V3_0 (ite MW_S2_V3 S2_V3_!286 V3_0))) (or (not R_S2_V2) (= V2_0 (ite MW_S2_V2 S2_V2_!287 V2_0))) (or (not R_S2_V5) (= V5_0 (ite MW_S2_V5 S2_V5_!288 V5_0))) (or (not R_S2_V4) (= V4_0 (ite MW_S2_V4 S2_V4_!289 V4_0))))) (= S2_V1_!285 S2_V1_!290)) (or (not (and (or (not R_S2_V1) (= (ite MW_S2_V1 S2_V1_!285 V1_0) (+ (- 1) V1_0))) (or (not R_S2_V3) (= (ite MW_S2_V3 S2_V3_!286 V3_0) V3_0)) (or (not R_S2_V2) (= (ite MW_S2_V2 S2_V2_!287 V2_0) V2_0)) (or (not R_S2_V5) (= (ite MW_S2_V5 S2_V5_!288 V5_0) V5_0)) (or (not R_S2_V4) (= (ite MW_S2_V4 S2_V4_!289 V4_0) V4_0)))) (= S2_V1_!290 S2_V1_!273)) (= S2_V2_!287 S2_V2_!275) (or (not (and (or (not R_S2_V1) (= V1_0 (+ 1 (ite MW_S2_V1 S2_V1_!285 V1_0)))) (or (not R_S2_V3) (= V3_0 (ite MW_S2_V3 S2_V3_!286 V3_0))) (or (not R_S2_V2) (= V2_0 (ite MW_S2_V2 S2_V2_!287 V2_0))) (or (not R_S2_V5) (= V5_0 (ite MW_S2_V5 S2_V5_!288 V5_0))) (or (not R_S2_V4) (= V4_0 (ite MW_S2_V4 S2_V4_!289 V4_0))))) (= S2_V2_!287 S2_V2_!292)) (or (not (and (or (not R_S2_V1) (= (ite MW_S2_V1 S2_V1_!285 V1_0) (+ (- 1) V1_0))) (or (not R_S2_V3) (= (ite MW_S2_V3 S2_V3_!286 V3_0) V3_0)) (or (not R_S2_V2) (= (ite MW_S2_V2 S2_V2_!287 V2_0) V2_0)) (or (not R_S2_V5) (= (ite MW_S2_V5 S2_V5_!288 V5_0) V5_0)) (or (not R_S2_V4) (= (ite MW_S2_V4 S2_V4_!289 V4_0) V4_0)))) (= S2_V2_!292 S2_V2_!275)) (= S2_V3_!286 S2_V3_!274) (or (not (and (or (not R_S2_V1) (= V1_0 (+ 1 (ite MW_S2_V1 S2_V1_!285 V1_0)))) (or (not R_S2_V3) (= V3_0 (ite MW_S2_V3 S2_V3_!286 V3_0))) (or (not R_S2_V2) (= V2_0 (ite MW_S2_V2 S2_V2_!287 V2_0))) (or (not R_S2_V5) (= V5_0 (ite MW_S2_V5 S2_V5_!288 V5_0))) (or (not R_S2_V4) (= V4_0 (ite MW_S2_V4 S2_V4_!289 V4_0))))) (= S2_V3_!286 S2_V3_!291)) (or (not (and (or (not R_S2_V1) (= (ite MW_S2_V1 S2_V1_!285 V1_0) (+ (- 1) V1_0))) (or (not R_S2_V3) (= (ite MW_S2_V3 S2_V3_!286 V3_0) V3_0)) (or (not R_S2_V2) (= (ite MW_S2_V2 S2_V2_!287 V2_0) V2_0)) (or (not R_S2_V5) (= (ite MW_S2_V5 S2_V5_!288 V5_0) V5_0)) (or (not R_S2_V4) (= (ite MW_S2_V4 S2_V4_!289 V4_0) V4_0)))) (= S2_V3_!291 S2_V3_!274)) (or (not MW_S1_V1) W_S1_V1) (or (not MW_S1_V2) W_S1_V2) (or (not MW_S1_V5) W_S1_V5) (or (not MW_S1_V4) W_S1_V4) (or (not MW_S2_V1) W_S2_V1) (or (not MW_S2_V3) W_S2_V3) (or (not MW_S2_V2) W_S2_V2) (or (not MW_S2_V5) W_S2_V5))) (not (and (not (<= V2_0 V1_0)) (not B1_!272) (not (<= (ite MW_S2_V2 S2_V2_!275 V2_0) (+ 1 (ite MW_S2_V1 S2_V1_!273 V1_0)))) B1_!278 (>= (synthTarget MW_S1_V1 S1_V1_!279 MW_S2_V1 S2_V1_!273 V1_0 ) (+ (- 1) (ite MW_S1_V2 S1_V2_!281 (ite MW_S2_V2 S2_V2_!275 V2_0)))) (not B1_!284) (not (<= (ite MW_S2_V2 S2_V2_!287 V2_0) (+ 1 (ite MW_S2_V1 S2_V1_!285 V1_0)))) (>= (synthTarget MW_S2_V1 S2_V1_!290 MW_S2_V1 S2_V1_!285 V1_0 ) (+ (- 1) (ite MW_S2_V2 S2_V2_!292 V2_0))))) (and (= (synthTarget MW_S1_V1 S1_V1_!279 MW_S2_V1 S2_V1_!273 V1_0 ) (synthTarget MW_S2_V1 S2_V1_!290 MW_S2_V1 S2_V1_!285 V1_0 )) (= (ite MW_S1_V3 S1_V3_!280 (ite MW_S2_V3 S2_V3_!274 V3_0)) (ite MW_S2_V3 S2_V3_!291 V3_0)) (= (ite MW_S1_V2 S1_V2_!281 (ite MW_S2_V2 S2_V2_!275 V2_0)) (ite MW_S2_V2 S2_V2_!292 V2_0)) (= (ite MW_S1_V5 S1_V5_!282 (ite MW_S2_V5 S2_V5_!276 V5_0)) (ite MW_S2_V5 S2_V5_!293 V5_0)) (= (ite MW_S1_V4 S1_V4_!283 (ite MW_S2_V4 S2_V4_!277 V4_0)) (ite MW_S2_V4 S2_V4_!294 V4_0)))))) (not (and (not R_B1_V1) DISJ_W_S2_R_B1)))))
(check-synth)
