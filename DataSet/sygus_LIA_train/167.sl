; Solution: (var_13711449326087013528 ? var_2038897368470328074 : 1 + (var_11837275621718647715 ? var_5926805518000257165 : var_9602199528432964299))

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

(synth-fun synthTarget((var_13711449326087013528 Bool)(var_2038897368470328074 Int)(var_11837275621718647715 Bool)(var_5926805518000257165 Int)(var_9602199528432964299 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_2038897368470328074 var_5926805518000257165 var_9602199528432964299 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool (var_13711449326087013528 var_11837275621718647715 (not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and DISJ_W_S2_R_B1 (not R_B1_V1) W_S1_V3 W_S2_V4 (= DISJ_W_S1_R_S1 (not (or (and W_S1_V1 R_S1_V1) R_S1_V3 (and W_S1_V2 R_S1_V2) (and W_S1_V5 R_S1_V5) (and W_S1_V4 R_S1_V4)))) (= DISJ_W_S1_R_S2 (not (or (and W_S1_V1 R_S2_V1) R_S2_V3 (and W_S1_V2 R_S2_V2) (and W_S1_V5 R_S2_V5) (and W_S1_V4 R_S2_V4)))) (= DISJ_W_S1_R_B1 (not (or R_B1_V3 (and W_S1_V2 R_B1_V2) (and W_S1_V5 R_B1_V5)))) (= DISJ_W_S1_W_S2 (not (or (and W_S1_V1 W_S2_V1) W_S2_V3 (and W_S1_V2 W_S2_V2) (and W_S1_V5 W_S2_V5) W_S1_V4))) (= DISJ_W_S2_R_S1 (not (or (and W_S2_V1 R_S1_V1) (and W_S2_V3 R_S1_V3) (and W_S2_V2 R_S1_V2) (and W_S2_V5 R_S1_V5) R_S1_V4))) (= DISJ_W_S2_R_S2 (not (or (and W_S2_V1 R_S2_V1) (and W_S2_V3 R_S2_V3) (and W_S2_V2 R_S2_V2) (and W_S2_V5 R_S2_V5) R_S2_V4))) (not (and W_S2_V3 R_B1_V3)) (forall ((V1_0 Int) (V3_0 Int) (V2_0 Int) (V5_0 Int) (V4_0 Int) (MW_S1_V1 Bool) (MW_S1_V3 Bool) (MW_S1_V2 Bool) (MW_S1_V5 Bool) (MW_S1_V4 Bool) (MW_S2_V1 Bool) (MW_S2_V3 Bool) (MW_S2_V2 Bool) (MW_S2_V5 Bool) (MW_S2_V4 Bool) (S1_V1_!1026 Int) (S1_V1_!1038 Int) (S1_V1_!1043 Int) (B1_!1025 Bool) (B1_!1031 Bool) (B1_!1037 Bool) (S2_V5_!1035 Int) (S1_V3_!1027 Int) (S1_V3_!1039 Int) (S1_V3_!1044 Int) (S1_V2_!1028 Int) (S1_V2_!1040 Int) (S1_V2_!1045 Int) (S2_V4_!1036 Int) (S1_V5_!1029 Int) (S1_V5_!1041 Int) (S1_V5_!1046 Int) (S2_V1_!1032 Int) (S1_V4_!1030 Int) (S1_V4_!1042 Int) (S1_V4_!1047 Int) (S2_V2_!1034 Int) (S2_V3_!1033 Int) )(or (not (and (= S1_V1_!1026 S1_V1_!1038) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V1_!1043 S1_V1_!1026)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V1_!1043 S1_V1_!1038)) (or (not (and (or (not R_B1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1027 V3_0))) (or (not R_B1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1028 V2_0))) (or (not R_B1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1029 V5_0))))) (= B1_!1025 B1_!1031)) (= B1_!1037 B1_!1025) (or (not (and (or (not R_B1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1027 V3_0))) (or (not R_B1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1028 V2_0))) (or (not R_B1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1029 V5_0))))) (= B1_!1037 B1_!1031)) (= S1_V3_!1027 S1_V3_!1039) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V3_!1044 S1_V3_!1027)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V3_!1044 S1_V3_!1039)) (= S1_V2_!1028 S1_V2_!1040) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V2_!1045 S1_V2_!1028)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V2_!1045 S1_V2_!1040)) (or (not (and (or (not R_S1_V1) (= V1_0 (+ 1 (ite MW_S1_V1 S1_V1_!1038 V1_0)))) (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1039 V3_0))) (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1040 V2_0))) (or (not R_S1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1041 V5_0))) (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!1042 V4_0))))) (= S1_V5_!1029 S1_V5_!1046)) (= S1_V5_!1041 S1_V5_!1029) (or (not (and (or (not R_S1_V1) (= V1_0 (+ 1 (ite MW_S1_V1 S1_V1_!1038 V1_0)))) (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1039 V3_0))) (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1040 V2_0))) (or (not R_S1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1041 V5_0))) (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!1042 V4_0))))) (= S1_V5_!1041 S1_V5_!1046)) (= S1_V4_!1030 S1_V4_!1042) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V4_!1047 S1_V4_!1030)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1038 V1_0) (+ (- 1) V1_0))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1039 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1040 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1041 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1042 V4_0) V4_0)))) (= S1_V4_!1047 S1_V4_!1042)) (or (not MW_S1_V1) W_S1_V1) (or (not MW_S1_V2) W_S1_V2) (or (not MW_S1_V5) W_S1_V5) (or (not MW_S1_V4) W_S1_V4) (or (not MW_S2_V1) W_S2_V1) (or (not MW_S2_V3) W_S2_V3) (or (not MW_S2_V2) W_S2_V2) (or (not MW_S2_V5) W_S2_V5))) (not (and (not (<= V2_0 V1_0)) B1_!1025 (not (<= (ite MW_S1_V2 S1_V2_!1028 V2_0) (+ 1 (ite MW_S1_V1 S1_V1_!1026 V1_0)))) (not B1_!1031) (>= (synthTarget MW_S2_V1 S2_V1_!1032 MW_S1_V1 S1_V1_!1026 V1_0 ) (+ (- 1) (ite MW_S2_V2 S2_V2_!1034 (ite MW_S1_V2 S1_V2_!1028 V2_0)))) B1_!1037 (not (<= (ite MW_S1_V2 S1_V2_!1040 V2_0) (+ 1 (ite MW_S1_V1 S1_V1_!1038 V1_0)))) (>= (synthTarget MW_S1_V1 S1_V1_!1043 MW_S1_V1 S1_V1_!1038 V1_0 ) (+ (- 1) (ite MW_S1_V2 S1_V2_!1045 V2_0))))) (and (= (synthTarget MW_S2_V1 S2_V1_!1032 MW_S1_V1 S1_V1_!1026 V1_0 ) (synthTarget MW_S1_V1 S1_V1_!1043 MW_S1_V1 S1_V1_!1038 V1_0 )) (= (ite MW_S2_V3 S2_V3_!1033 (ite MW_S1_V3 S1_V3_!1027 V3_0)) (ite MW_S1_V3 S1_V3_!1044 V3_0)) (= (ite MW_S2_V2 S2_V2_!1034 (ite MW_S1_V2 S1_V2_!1028 V2_0)) (ite MW_S1_V2 S1_V2_!1045 V2_0)) (= (ite MW_S2_V5 S2_V5_!1035 (ite MW_S1_V5 S1_V5_!1029 V5_0)) (ite MW_S1_V5 S1_V5_!1046 V5_0)) (= (ite MW_S2_V4 S2_V4_!1036 (ite MW_S1_V4 S1_V4_!1030 V4_0)) (ite MW_S1_V4 S1_V4_!1047 V4_0))))) (not (and W_S2_V2 R_B1_V2)) (not (and W_S2_V5 R_B1_V5)) (not R_B1_V4)) (not DISJ_W_S1_R_B1))))
(check-synth)
