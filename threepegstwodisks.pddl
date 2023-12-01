(define (problem threepegstwodisks)
	(:domain towerofhanoi)
	(:objects peg1 peg2 peg3 disk1 disk2)
	(:init (on disk2 peg1)
	       (on disk1 disk2)
	       (clear disk1)
	       (clear peg2)
	       (clear peg3)
	       (smaller disk1 disk2)
	       (smaller disk1 peg1)
	       (smaller disk1 peg2)
	       (smaller disk1 peg3)
	       (smaller disk2 peg1)
	       (smaller disk2 peg2)
	       (smaller disk2 peg))
	(:goal (and (on disk1 disk2) (on disk2 peg3))))
	       