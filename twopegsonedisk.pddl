(define (problem twopegsonedisk)
	(:domain towerofhanoi)
	(:objects peg1 peg2 disk1)
	(:init (on disk1 peg1)
	       (clear disk1)
	       (clear peg2)
	       (smaller disk1 peg1)
	       (smaller disk1 peg2))
	(:goal (on disk1 peg2)))