(defmacro test-case (test result)
  `(let ((actual ,test))
     (if (equal actual ,result)
	 (format t "PASS")
	 (format t "FAIL"))
     (format t " ~a == ~a, got ~a~%" (quote ,test) ,result actual)))

;; test exp->nnf
;; test %DIST-OR-AND-1
;; test %DIST-OR-AND-AND
;; test dpll-unit-propagate
;; test dpll
(test-case (sat-p '(and a b)) t)
(test-case (sat-p '(and (or a) (or (not a)))) nil)
