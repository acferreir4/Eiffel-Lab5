note
	description: "A default spaghetti model."
	author: "Dan Sheng"
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
		local
			dummy_player: PLAYER
		do
			create player_one.make ("", "X", 1)
			create player_two.make ("", "O", 2)
			create next_player.make ("", "", 0)
			create dummy_player.make ("", "", 0)
			create {ARRAYED_LIST[TUPLE [player: PLAYER; position: INTEGER; status: STRING]]} move_list.make (0)

			status_message := "ok"
			player_turn := 1
			current_move := 1
			redo_allowed := false

			move_list.force (dummy_player, 0, "ok")
		end

feature {BOARD} -- board attributes

	move_list: LIST[TUPLE [player: PLAYER; position: INTEGER; status: STRING]]	-- history of moves done
	current_move: INTEGER														-- pointer for list of moves, show current moves
	player_one, player_two, next_player: PLAYER									-- players, next_player used for printing
	game_in_play: BOOLEAN														-- if false, undo and redo are not possible
	status_message: STRING														-- stores status message to output
	player_turn: INTEGER														-- stores whose turn it is
	redo_allowed: BOOLEAN														-- allows redo operations
	game_won: BOOLEAN

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
			next_player := player_one
		end

	play_again
		do
			current_move := 1
			game_in_play := true
			redo_allowed := false
		end

	play (a_player_name: STRING; a_move: INTEGER)
--		Insert a new move into the move_list, assume defensive checks
		local
			current_player: PLAYER
			current_player_move: TUPLE[player: PLAYER; position: INTEGER; status: STRING]
		do
			if a_player_name ~ player_one.get_name then
				current_player := player_one
				next_player := player_two
			else
				current_player := player_two
				next_player := player_one
			end

			current_player_move := [current_player, a_move, "ok"]
--			move_list.force (current_player_move)
			if move_list.count > current_move then
				move_list[current_move] := current_player_move
			else
				move_list.force (current_player_move)
			end
			redo_allowed := false
			if player_turn = 1 then
				player_turn := 2
			else
				player_turn := 1
			end
			current_move := current_move + 1
--			check_for_win
		end

	undo
		do
			if current_move > 1 and game_in_play then
				current_move := current_move - 1
				redo_allowed := true
			end
		end

	redo
		do
			if redo_allowed and move_list.count >= current_move + 1 then
				current_move := current_move + 1
			end
		end

feature -- Defensive Queries

	is_valid_move (a_move: INTEGER): BOOLEAN
		local
			i: INTEGER
			stop: BOOLEAN
		do
			Result := true												-- true until contradition occurs
			if a_move >= 1 and a_move <= 9 then
				from
					i := 1
				until
					i = current_move or stop
				loop
					if move_list[i].position = a_move then
						Result := false
						stop := true
					end
					i := i + 1
				end
			else
				Result := false
			end
		end

	is_their_turn (a_player_name: STRING): BOOLEAN
		local
			argument_player: PLAYER
		do
			if a_player_name ~ player_one.get_name then
				argument_player := player_one
			else
				argument_player := player_two
			end
			Result := argument_player.get_id = player_turn
		end

	player_exists (a_player_name: STRING): BOOLEAN
		do
			Result := a_player_name ~ player_one.get_name or a_player_name ~ player_two.get_name
		end

	is_alpha_name (a_player_name: STRING): BOOLEAN
		do
			Result := a_player_name[1].is_alpha
		end

	play_again_allowed: BOOLEAN
		do
			Result := game_in_play = false and game_won = true
		end

feature	-- status message commands

	status_flag (a_flag: INTEGER)
	do
		inspect a_flag
		when 0 then status_message := "ok"
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

	invalid_command (a_status_message: STRING)
	local
		dummy_player: PLAYER
		status_move: TUPLE [player: PLAYER; position: INTEGER; status: STRING]
	do
		create dummy_player.make ("", "", 0)
		status_move := [dummy_player, 0, a_status_message]
		move_list.force (status_move)
		current_move := current_move + 1
	end

feature	-- status message queries

	get_status_message: STRING
	do
		Result := status_message
	end

	get_previous_status_message: STRING
	do
		if current_move > 1 then
			Result := move_list[current_move - 1].status
		else
			Result := ""
		end

	end

feature {BOARD} -- Hidden Commands

	check_for_win
--		Check after every move, invisible to other classes
--		Scan from 1..current_move in move_list
--		If someone won, increment their wins, turn game_in_play to false, game_won to true, call other invisible function
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
				Result.append ("start new game%N  ")
			elseif game_won = true then
				Result.append ("play again or start new game%N  ")
			else
				Result.append (next_player.get_name)
				Result.append (" plays next%N  ")
			end
			Result.append (print_board)
			Result.append ("%N  ")

			Result.append (player_one.get_wins.out)
			Result.append (": score for %"")
			Result.append (player_one.get_name)
			Result.append ("%" (as X)%N  ")

			Result.append (player_two.get_wins.out)
			Result.append (": score for %"")
			Result.append (player_two.get_name)
			Result.append ("%" (as O)")
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
					top_row.remove (move_list[i].position)
					if move_list[i].player.get_piece ~ "X" or move_list[i].player.get_piece ~ "O" then
						top_row.insert_string (move_list[i].player.get_piece, move_list[i].position)
					else
						top_row.insert_string ("_", i)
					end
				elseif move_list[i].position >= 4 and move_list[i].position <= 6 then
					mid_row.remove (move_list[i].position - 3)
					if move_list[i].player.get_piece ~ "X" or move_list[i].player.get_piece ~ "O" then
						mid_row.insert_string (move_list[i].player.get_piece, move_list[i].position - 3)
					else
						mid_row.insert_string ("_", i)
					end
				elseif move_list[i].position >= 7 and move_list[i].position <= 9 then
					bot_row.remove (move_list[i].position - 6)
					if move_list[i].player.get_piece ~ "X" or move_list[i].player.get_piece ~ "O" then
						bot_row.insert_string (move_list[i].player.get_piece, move_list[i].position - 6)
					else
						bot_row.insert_string ("_", i)
					end
				end
				i := i + 1
			end

			Result.append (top_row)
			Result.append ("%N  ")
			Result.append (mid_row)
			Result.append ("%N  ")
			Result.append (bot_row)
		end

feature -- model operations

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")

			Result.append (move_list[current_move-1].status)			-- fix this shit, new_game("A", "A") gives ok if first command

			Result.append (print_message)
			status_message := ""
		end

end




