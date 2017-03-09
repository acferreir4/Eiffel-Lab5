# Eiffel-Lab5

ToDo:

	- Double check undo and redo
	
	- Fix play()
		- Add check_for_win and win_condition
			- Have status_flags [8] and [9] triggered by win_condition
		- Printing pieces on board delayed by 1 command
			- Similarly, the "XXX plays next" part delays too
			- Undo function instantaneously update display...
		- May need to change how writing to list works (use cursor)
		
	- Acceptance tests
