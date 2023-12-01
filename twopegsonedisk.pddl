(define (problem twopegsonedisk)
	(:domain towerofhanoi)
	(:objects peg1 peg2 disk1)
	(:init (on disk1 peg1)
	       (clear disk1)
	       (clear peg2)
	       (smaller peg1 disk1)
	       (smaller peg2 disk1))
	(:goal (on disk1 peg2)))