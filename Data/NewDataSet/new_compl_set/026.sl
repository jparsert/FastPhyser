; Solution: -1 + var_12486367986339448112

(set-logic LIA)
(declare-var DISJ_W_S1_R_E1 Bool)

(declare-var DISJ_W_S1_R_S1 Bool)

(declare-var DISJ_W_S1_R_S2 Bool)

(declare-var DISJ_W_S1_W_S2 Bool)

(declare-var DISJ_W_S2_R_E1 Bool)

(declare-var DISJ_W_S2_R_S1 Bool)

(declare-var DISJ_W_S2_R_S2 Bool)

(declare-var R_E1_V1 Bool)

(declare-var R_E1_V2 Bool)

(declare-var R_E1_V3 Bool)

(declare-var R_E1_V4 Bool)

(declare-var R_E1_V5 Bool)

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

(synth-fun synthTarget((var_12486367986339448112 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_12486367986339448112 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (not (and (and DISJ_W_S1_R_E1 (not R_E1_V1) (not W_S1_V1) (not W_S1_V2) W_S1_V3 W_S2_V4 (= DISJ_W_S1_R_S1 (not (or R_S1_V3 (and W_S1_V5 R_S1_V5) (and W_S1_V4 R_S1_V4)))) (= DISJ_W_S1_R_S2 (not (or R_S2_V3 (and W_S1_V5 R_S2_V5) (and W_S1_V4 R_S2_V4)))) (not R_E1_V3) (= DISJ_W_S1_W_S2 (not (or W_S2_V3 (and W_S1_V5 W_S2_V5) W_S1_V4))) (= DISJ_W_S2_R_S1 (not (or (and W_S2_V1 R_S1_V1) (and W_S2_V3 R_S1_V3) (and W_S2_V2 R_S1_V2) (and W_S2_V5 R_S1_V5) R_S1_V4))) (= DISJ_W_S2_R_S2 (not (or (and W_S2_V1 R_S2_V1) (and W_S2_V3 R_S2_V3) (and W_S2_V2 R_S2_V2) (and W_S2_V5 R_S2_V5) R_S2_V4))) (= DISJ_W_S2_R_E1 (not (or (and W_S2_V2 R_E1_V2) (and W_S2_V5 R_E1_V5) R_E1_V4))) (forall ((V3_0 Int) (V2_0 Int) (V5_0 Int) (V4_0 Int) (MW_S1_V1 Bool) (MW_S1_V3 Bool) (MW_S1_V2 Bool) (MW_S1_V5 Bool) (MW_S1_V4 Bool) (MW_S2_V1 Bool) (MW_S2_V3 Bool) (MW_S2_V2 Bool) (MW_S2_V5 Bool) (MW_S2_V4 Bool) (S1_V1_!1516 Int) (S1_V1_!1527 Int) (S1_V1_!1532 Int) (S2_V5_!1524 Int) (S2_V5_!1541 Int) (S1_V3_!1517 Int) (S1_V3_!1528 Int) (S1_V3_!1533 Int) (S1_V2_!1518 Int) (S1_V2_!1529 Int) (S1_V2_!1534 Int) (E1_!1515 Int) (E1_!1526 Int) (E1_!1537 Int) (S2_V4_!1525 Int) (S2_V4_!1542 Int) (S1_V5_!1519 Int) (S1_V5_!1530 Int) (S1_V5_!1535 Int) (S2_V1_!1521 Int) (S2_V1_!1538 Int) (S1_V4_!1520 Int) (S1_V4_!1531 Int) (S1_V4_!1536 Int) (S2_V2_!1523 Int) (S2_V2_!1540 Int) (S2_V3_!1522 Int) (S2_V3_!1539 Int) )(or (not (and (or (not (or (not R_S1_V1) (= E1_!1515 E1_!1526))) (= S1_V1_!1516 S1_V1_!1527)) (or (not (and (or (not R_S1_V1) (= E1_!1515 (+ 1 (ite MW_S1_V1 S1_V1_!1527 E1_!1526)))) (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1528 V3_0))) (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1529 V2_0))) (or (not R_S1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1530 V5_0))) (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!1531 V4_0))))) (= S1_V1_!1516 S1_V1_!1532)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1526 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V1_!1532 S1_V1_!1527)) (or (not (and (or (not R_S2_V1) (= E1_!1537 (ite MW_S1_V1 S1_V1_!1516 E1_!1515))) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!1533 V3_0) (ite MW_S1_V3 S1_V3_!1517 V3_0))) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!1534 V2_0) (ite MW_S1_V2 S1_V2_!1518 V2_0))) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!1535 V5_0) (ite MW_S1_V5 S1_V5_!1519 V5_0))) (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!1536 V4_0) (ite MW_S1_V4 S1_V4_!1520 V4_0))))) (= S2_V5_!1541 S2_V5_!1524)) (or (not (or (not R_S1_V1) (= E1_!1515 E1_!1526))) (= S1_V3_!1517 S1_V3_!1528)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1515 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V3_!1533 S1_V3_!1517)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1526 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V3_!1533 S1_V3_!1528)) (or (not (or (not R_S1_V1) (= E1_!1515 E1_!1526))) (= S1_V2_!1518 S1_V2_!1529)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1515 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V2_!1534 S1_V2_!1518)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1526 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V2_!1534 S1_V2_!1529)) (= E1_!1515 E1_!1526) (or (not (and (or (not R_E1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1534 V2_0))) (or (not R_E1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1535 V5_0))) (or (not R_E1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!1536 V4_0))))) (= E1_!1515 E1_!1537)) (or (not (and (or (not R_E1_V2) (= (ite MW_S1_V2 S1_V2_!1534 V2_0) V2_0)) (or (not R_E1_V5) (= (ite MW_S1_V5 S1_V5_!1535 V5_0) V5_0)) (or (not R_E1_V4) (= (ite MW_S1_V4 S1_V4_!1536 V4_0) V4_0)))) (= E1_!1537 E1_!1526)) (or (not (and (or (not R_S2_V1) (= E1_!1537 (ite MW_S1_V1 S1_V1_!1516 E1_!1515))) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!1533 V3_0) (ite MW_S1_V3 S1_V3_!1517 V3_0))) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!1534 V2_0) (ite MW_S1_V2 S1_V2_!1518 V2_0))) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!1535 V5_0) (ite MW_S1_V5 S1_V5_!1519 V5_0))) (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!1536 V4_0) (ite MW_S1_V4 S1_V4_!1520 V4_0))))) (= S2_V4_!1542 S2_V4_!1525)) (or (not (and (or (not R_S1_V1) (= E1_!1515 (+ 1 (ite MW_S1_V1 S1_V1_!1527 E1_!1526)))) (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1528 V3_0))) (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1529 V2_0))) (or (not R_S1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1530 V5_0))) (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!1531 V4_0))))) (= S1_V5_!1519 S1_V5_!1535)) (or (not (or (not R_S1_V1) (= E1_!1526 E1_!1515))) (= S1_V5_!1530 S1_V5_!1519)) (or (not (and (or (not R_S1_V1) (= E1_!1526 (+ 1 (ite MW_S1_V1 S1_V1_!1527 E1_!1526)))) (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!1528 V3_0))) (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!1529 V2_0))) (or (not R_S1_V5) (= V5_0 (ite MW_S1_V5 S1_V5_!1530 V5_0))) (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!1531 V4_0))))) (= S1_V5_!1530 S1_V5_!1535)) (or (not (and (or (not R_S2_V1) (= E1_!1537 (ite MW_S1_V1 S1_V1_!1516 E1_!1515))) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!1533 V3_0) (ite MW_S1_V3 S1_V3_!1517 V3_0))) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!1534 V2_0) (ite MW_S1_V2 S1_V2_!1518 V2_0))) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!1535 V5_0) (ite MW_S1_V5 S1_V5_!1519 V5_0))) (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!1536 V4_0) (ite MW_S1_V4 S1_V4_!1520 V4_0))))) (= S2_V1_!1538 S2_V1_!1521)) (or (not (or (not R_S1_V1) (= E1_!1526 E1_!1515))) (= S1_V4_!1531 S1_V4_!1520)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1515 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V4_!1536 S1_V4_!1520)) (or (not (and (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!1527 E1_!1526) (synthTarget E1_!1526 ))) (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!1528 V3_0) V3_0)) (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!1529 V2_0) V2_0)) (or (not R_S1_V5) (= (ite MW_S1_V5 S1_V5_!1530 V5_0) V5_0)) (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!1531 V4_0) V4_0)))) (= S1_V4_!1536 S1_V4_!1531)) (or (not (and (or (not R_S2_V1) (= E1_!1537 (ite MW_S1_V1 S1_V1_!1516 E1_!1515))) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!1533 V3_0) (ite MW_S1_V3 S1_V3_!1517 V3_0))) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!1534 V2_0) (ite MW_S1_V2 S1_V2_!1518 V2_0))) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!1535 V5_0) (ite MW_S1_V5 S1_V5_!1519 V5_0))) (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!1536 V4_0) (ite MW_S1_V4 S1_V4_!1520 V4_0))))) (= S2_V2_!1540 S2_V2_!1523)) (or (not (and (or (not R_S2_V1) (= E1_!1537 (ite MW_S1_V1 S1_V1_!1516 E1_!1515))) (or (not R_S2_V3) (= (ite MW_S1_V3 S1_V3_!1533 V3_0) (ite MW_S1_V3 S1_V3_!1517 V3_0))) (or (not R_S2_V2) (= (ite MW_S1_V2 S1_V2_!1534 V2_0) (ite MW_S1_V2 S1_V2_!1518 V2_0))) (or (not R_S2_V5) (= (ite MW_S1_V5 S1_V5_!1535 V5_0) (ite MW_S1_V5 S1_V5_!1519 V5_0))) (or (not R_S2_V4) (= (ite MW_S1_V4 S1_V4_!1536 V4_0) (ite MW_S1_V4 S1_V4_!1520 V4_0))))) (= S2_V3_!1539 S2_V3_!1522)) (not MW_S1_V1) (not MW_S1_V2) (or (not MW_S1_V5) W_S1_V5) (or (not MW_S1_V4) W_S1_V4) (or (not MW_S2_V1) W_S2_V1) (or (not MW_S2_V3) W_S2_V3) (or (not MW_S2_V2) W_S2_V2) (or (not MW_S2_V5) W_S2_V5))) (not (and (not (<= V2_0 E1_!1515)) (>= (ite MW_S2_V1 S2_V1_!1521 (ite MW_S1_V1 S1_V1_!1516 E1_!1515)) (+ (- 1) (ite MW_S2_V2 S2_V2_!1523 (ite MW_S1_V2 S1_V2_!1518 V2_0)))) (not (<= V2_0 E1_!1526)) (not (<= (ite MW_S1_V2 S1_V2_!1529 V2_0) (+ 1 (ite MW_S1_V1 S1_V1_!1527 E1_!1526)))) (>= (ite MW_S1_V1 S1_V1_!1532 (+ 1 (ite MW_S1_V1 S1_V1_!1527 E1_!1526))) (+ (- 1) (ite MW_S1_V2 S1_V2_!1534 V2_0))) (not (<= (ite MW_S1_V2 S1_V2_!1534 V2_0) E1_!1537)) (>= (ite MW_S2_V1 S2_V1_!1538 E1_!1537) (+ (- 1) (ite MW_S2_V2 S2_V2_!1540 (ite MW_S1_V2 S1_V2_!1534 V2_0)))))) (and (= (ite MW_S2_V1 S2_V1_!1521 (ite MW_S1_V1 S1_V1_!1516 E1_!1515)) (ite MW_S2_V1 S2_V1_!1538 E1_!1537)) (= (ite MW_S2_V3 S2_V3_!1522 (ite MW_S1_V3 S1_V3_!1517 V3_0)) (ite MW_S2_V3 S2_V3_!1539 (ite MW_S1_V3 S1_V3_!1533 V3_0))) (= (ite MW_S2_V2 S2_V2_!1523 (ite MW_S1_V2 S1_V2_!1518 V2_0)) (ite MW_S2_V2 S2_V2_!1540 (ite MW_S1_V2 S1_V2_!1534 V2_0))) (= (ite MW_S2_V5 S2_V5_!1524 (ite MW_S1_V5 S1_V5_!1519 V5_0)) (ite MW_S2_V5 S2_V5_!1541 (ite MW_S1_V5 S1_V5_!1535 V5_0))) (= (ite MW_S2_V4 S2_V4_!1525 (ite MW_S1_V4 S1_V4_!1520 V4_0)) (ite MW_S2_V4 S2_V4_!1542 (ite MW_S1_V4 S1_V4_!1536 V4_0)))))) (not (and W_S1_V5 R_E1_V5)) (not (and W_S1_V4 R_E1_V4))) (not (and (not W_S2_V2) DISJ_W_S2_R_S1 DISJ_W_S1_R_S1)) (not (and (not W_S2_V1) (not W_S2_V2))) (not (and (not R_S1_V1) DISJ_W_S1_R_S1)))))
(check-synth)
