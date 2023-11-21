(defmacro test-case (test result)
  `(let ((actual ,test))
     (if (equal actual ,result)
	 (format t "PASS")
	 (format t "FAIL"))
     (assert (eq actual ,result))
     (format t " ~a == ~a, got ~a~%" (quote ,test) ,result actual)))

;; test exp->nnf
;; test %DIST-OR-AND-1
;; test %DIST-OR-AND-AND
;; test dpll-unit-propagate
;; test dpll

;; Individual test cases
(test-case (sat-p '(and a b)) t)
(test-case (sat-p '(and (not a) a)) nil)
(test-case (sat-p '(or a b)) t)
(test-case (sat-p '(:xor a b)) t)
(test-case (sat-p '(:xor a a)) nil)
(test-case (sat-p '(:xor (not a) a)) t)
(test-case (sat-p '(:iff a a)) t)
(test-case (sat-p '(:iff a b)) t)
(test-case (sat-p '(:iff a (not a))) nil)
(test-case (sat-p '(:implies a a)) t)

;; Combined test cases
;; Fails implies, a must be true and b must be false
(test-case (sat-p '(and a (not b) (:implies a b))) nil)
(test-case (sat-p '(and a (not b) (:xor a b))) t)
(test-case (sat-p '(and a b (:xor a b))) nil)
(test-case (sat-p '(and (and a b) (:xor a b))) nil)
(test-case (sat-p '(and (or a) (or (not a)))) nil)
(test-case (sat-p '(or (:xor a b) (:iff a b))) t)
(test-case (sat-p '(and a (and a (and a (and a (not a)))))) nil)
(test-case (sat-p '(and a (and a (and a (and a a))))) t)
(test-case (sat-p '(and (:xor a b) (:iff a b))) nil)
(test-case (sat-p '(and (or a (not b)) (or b (not c)) (or c (not a)))) t)
(test-case (sat-p '(and (or a b c) (or (not a) (not b) (not c)))) t)
(test-case (sat-p '(and (or a (not b)) (or b (not c)) (or c (not a)) (or a b c) (or (not a) (not b) (not c)))) nil)
(test-case (sat-p '(and (or a b c) (or b (not c) (not f)) (or (not b) e))) t)
(test-case (sat-p '(and (or a b) (or a (not b)) (or (not a) c) (or (not a) (not c)))) nil)
(test-case (sat-p '(and (or a (not b) c) (and a (or (not a) b) c))) t)
(test-case (sat-p '(and (or a b c) (or (not a) b) (or a (not c)) (or (not b) c) (or (not a) (not b) (not c)))) nil)
(test-case (sat-p '(and a b c d e f g h i j k l m n o p q r s u v w x y z)) t)
(test-case (sat-p '(and (or a b c d e f g h i j k l m n o p) q)) t)
