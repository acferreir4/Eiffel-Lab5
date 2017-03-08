note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit
	ANY
		redefine
			out
		end

create {BOARD_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create player_one.make ("", "X", 1)
			create player_two.make ("", "O", 2)
			current_turn := 1
			create {ARRAYED_LIST[TUPLE [player: PLAYER; position: INTEGER; piece: STRING]]} move_list.make (0)
			current_move := 1

			i := 0						-- bullshit, remove soon
		end

feature -- board attributes

	i : INTEGER							-- bullshit, remove soon

	move_list: LIST[TUPLE [player: PLAYER; position: INTEGER; piece: STRING]]	-- history of moves done
	current_move: INTEGER														-- pointer for list of moves, show current moves
	player_one, player_two: PLAYER												-- players
	game_in_play: BOOLEAN														-- if false, undo and redo are not possible

feature {BOARD} -- hidden board attributes

	current_turn: INTEGER														-- stores whose turn it is

feature -- Commands

	new_game (a_player_one_name: STRING; a_player_two_name: STRING)
--		Change player one and player two to new names, reset their wins
--		Clear the board, reset the pointer
		do
			player_one.change_name (a_player_one_name)
			player_one.reset_won
			player_two.change_name (a_player_two_name)
			player_two.reset_won
			current_move := 1
			game_in_play := true
		end

	play_again
		do
			current_move := 1
			game_in_play := true
		end

	play (a_player_name: STRING; a_move: INTEGER)
--		Insert a new move into the move_list, assume defensive checks
		local
			current_player: PLAYER
			current_player_move: TUPLE[player: PLAYER; position: INTEGER; piece: STRING]
		do
			if a_player_name ~ player_one.get_name then
				current_player := player_one
			else
				current_player := player_two
			end
			current_player_move := [current_player, a_move, current_player.get_piece]
			move_list.force (current_player_move)
			check_for_win
		end

feature -- Defensive Queries

	is_valid_move (a_move: INTEGER): BOOLEAN
--		Checks if a_move is between 1-9, and if it is available
		do
			if a_move >= 1 and a_move <= 9 then
				Result := true												-- ToDo: Scan across move_list
			else
				Result := false
			end
		end

	is_their_turn (a_player_name: STRING): BOOLEAN
--		Compare a_player_name's id with current_turn
		local
			argument_player: PLAYER
		do
			if a_player_name ~ player_one.get_name then
				argument_player := player_one
			else
				argument_player := player_two
			end
			if argument_player.get_id = current_turn then
				Result := true
			else
				Result := false
			end
		end

	player_exists (a_player_name: STRING): BOOLEAN
--		Check if a player with such a name exists
		do
			Result := a_player_name ~ player_one.get_name  or a_player_name ~ player_two.get_name
		end

	is_alpha_name (a_player_name: STRING): BOOLEAN
		do
			Result := a_player_name[1].is_alpha
		end

feature {BOARD} -- Hidden Commands

	check_for_win
--		Check after every move, invisible to other classes
--		Scan from 1..current_move in move_list
--		If someone won, increment their wins, turn game_in_play to false, call other invisible function
--		asking if they want to play again or new game
		do

		end

	win_condition
--		Ask if they want to play again and reset the board
		do
			move_list.wipe_out
		end

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (i.out)
			Result.append (")")
		end

end




