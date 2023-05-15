; smt-lib-version 2.6
; category industrial
; status sat
; Solution: var_7947610294955781580 * 0 + (var_5280962433790937196 * 0 + (0 * var_8812319150302687725 + (var_15656837162691451457 * var_957991389188131014 + (var_16519217489994238401 * var_10685257929166800329 + (var_16449010777835977833 * var_5279620116567085023 + var_13564982501789847388)))))

(set-logic LIA)
(synth-fun synthTarget((var_7947610294955781580 Int)(var_5280962433790937196 Int)(var_8812319150302687725 Int)(var_15656837162691451457 Int)(var_957991389188131014 Int)(var_16519217489994238401 Int)(var_10685257929166800329 Int)(var_16449010777835977833 Int)(var_5279620116567085023 Int)(var_13564982501789847388 Int)) Int
((NTInt Int)(NTbool Bool))
((NTInt Int (var_7947610294955781580 var_5280962433790937196 var_8812319150302687725 var_15656837162691451457 var_957991389188131014 var_16519217489994238401 var_10685257929166800329 var_16449010777835977833 var_5279620116567085023 var_13564982501789847388 0 1 (- NTInt) (+ NTInt NTInt) (- NTInt NTInt) (ite NTbool NTInt NTInt) ))
(NTbool Bool ((not NTbool) (and NTbool NTbool) (or NTbool NTbool) (ite NTbool NTbool NTbool) (= NTInt NTInt) (< NTInt NTInt) (> NTInt NTInt) ))
)
)

(constraint (and (<= (+ (* (- 1) 0) (+ (* (- 1) 0) (+ (* (- 1) 0) (+ (* 0 0) (+ (* 0 (- 1)) (* 1 1)))))) 1) (<= (synthTarget (- 1) (- 1) (- 1) 0 0 0 0 0 1 (* 1 (- 1)) ) 0) (<= (synthTarget (- 1) (- 1) 0 1 0 0 0 0 1 (* 1 0) ) 1) (<= (synthTarget 0 0 0 0 0 0 0 0 1 (* 1 (- 1)) ) (- 1)) (<= (synthTarget 1 0 0 0 0 0 (- 1) 1 (- 1) (+ (* 1 0) (* 1 0)) ) (- 1))))
(check-synth)
