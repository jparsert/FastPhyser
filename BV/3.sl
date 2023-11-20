(set-logic BV)

(synth-fun SC ((s (_ BitVec 4)) (t (_ BitVec 4))) Bool
((B Bool) (BV (_ BitVec 4)))(
	(B Bool
		(true
		false
		(= BV BV)
		(bvult BV BV)
		(and B B)
		(or B B)
		(not B)))
	(BV (_ BitVec 4)
		(s t
		#x0 #x1
		(bvadd BV BV)
		(bvand BV BV)
		(bvashr BV BV)
		(bvlshr BV BV)
		(bvmul BV BV)
		(bvneg BV)
		(bvnot BV)
		(bvor BV BV)
		(bvsdiv BV BV)
		(bvshl BV BV)
		(bvsrem BV BV)
		(bvsub BV BV)
		(bvudiv BV BV)
		(bvurem BV BV)
		(bvxor BV BV)
		(ite B BV BV)))))

(declare-var s (_ BitVec 4))
(declare-var t (_ BitVec 4))
(define-fun udivtotal ((a (_ BitVec 4)) (b (_ BitVec 4))) (_ BitVec 4)
    (ite (= b #x0) #xF (bvudiv a b)))
(define-fun uremtotal ((a (_ BitVec 4)) (b (_ BitVec 4))) (_ BitVec 4)
    (ite (= b #x0) a (bvurem a b)))
(define-fun case ((x (_ BitVec 4)) (s (_ BitVec 4)) (t (_ BitVec 4))) Bool
    (bvsge (bvmul x s) t))
(constraint (= (or (case #x0 s t) (case #x1 s t) (case #x2 s t) (case #x3 s t) (case #x4 s t) (case #x5 s t) (case #x6 s t) (case #x7 s t) (case #x8 s t) (case #x9 s t) (case #xA s t) (case #xB s t) (case #xC s t) (case #xD s t) (case #xE s t) (case #xF s t)) (SC s t)))

(check-synth)
