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
			create next_player.make ("", "", 0)
			create status_message.make_empty
			current_turn := 1
			create {ARRAYED_LIST[TUPLE [player: PLAYER; position: INTEGER; piece: STRING]]} move_list.make (0)
			current_move := 1

			abc := 0						-- bullshit, remove soon
		end

feature {BOARD} -- board attributes

	abc : INTEGER							-- bullshit, remove soon

	move_list: LIST[TUPLE [player: PLAYER; position: INTEGER; piece: STRING]]	-- history of moves done
	current_move: INTEGER														-- pointer for list of moves, show current moves
	player_one, player_two, next_player: PLAYER									-- players
	game_in_play: BOOLEAN														-- if false, undo and redo are not possible
	status_message: STRING														-- stores status message to output
	current_turn: INTEGER														-- stores whose turn it is

feature -- User Commands

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
				next_player := player_two
			else
				current_player := player_two
				next_player := player_one
			end
			current_player_move := [current_player, a_move, current_player.get_piece]
			move_list.force (current_player_move)
			check_for_win
		end

	undo
		do

		end

	redo
		do

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
			Result := argument_player.get_id = current_turn
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

feature	-- status messages

	status_flag (a_flag: INTEGER)
	do
		inspect a_flag
		when 1 then status_message := "names of players must be different"
		when 2 then status_message := "name must start with A-Z or a-z"
		when 3 then status_message := "not this player's turn"
		when 4 then status_message := "no such player"
		when 5 then status_message := "button already taken"
		when 6 then status_message := "there is a winner"
		when 7 then status_message := "finish this game first"
		when 8 then status_message := "game is finished"
		when 9 then status_message := "game ended in a tie"
		else
					status_message := ""
		end
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

feature {BOARD} -- Hidden Queries

	print_message: STRING
		do
			create Result.make_from_string ("")
			Result.append (": => ")
			if player_one.get_name ~ "" then
				Result.append ("start new game%N")
			else
				Result.append (next_player.get_name)
				Result.append ("plays next%N")
			end
			Result.append (print_board)
			Result.append ("%N")

			Result.append (player_one.get_wins.out)
			Result.append (": score for %"")
			Result.append (player_one.get_name)
			Result.append ("%" (as X)%N")

			Result.append (player_two.get_wins.out)
			Result.append (": score for %"")
			Result.append (player_two.get_name)
			Result.append ("%" (as O)%N")
		end

	print_board: STRING
		local
			output: STRING
			top_row, mid_row, bot_row: STRING
			i: INTEGER
		do
			create Result.make_from_string ("")
			top_row := "___"
			mid_row := "___"
			bot_row := "___"

			from
				i := 1
			until
				i = current_move
			loop
				if move_list[i].position >= 1 and move_list[i].position <= 3 then
					top_row.remove (i)
					if move_list[i].piece ~ "X" or move_list[i].piece ~ "O" then
						top_row.insert_string (move_list[i].piece, i)
					else
						top_row.insert_string ("_", i)
					end
				elseif move_list[i].position >= 4 and move_list[i].position <= 6 then
					mid_row.remove (i)
					if move_list[i].piece ~ "X" or move_list[i].piece ~ "O" then
						mid_row.insert_string (move_list[i].piece, i)
					else
						mid_row.insert_string ("_", i)
					end
				else
					bot_row.remove (i)
					if move_list[i].piece ~ "X" or move_list[i].piece ~ "O" then
						bot_row.insert_string (move_list[i].piece, i)
					else
						bot_row.insert_string ("_", i)
					end
				end
			end

			Result.append (top_row)
			Result.append ("%N")
			Result.append (mid_row)
			Result.append ("%N")
			Result.append (bot_row)
		end

	print_tile_at (position: INTEGER): STRING
		do
			Result := ""
		end

feature -- model operations
	default_update
			-- Perform update to the model state.		bullshit delete
		do
			abc := abc + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("")
			if status_message ~ "" then
				Result.append ("ok")
			else
				Result.append (status_message)
			end
			Result.append (print_message)
			status_message := ""
		end

end




