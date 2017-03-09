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
			redo_allowed := false

			move_list.force (dummy_player, 0, "ok")
			move_list.forth
		end

feature {BOARD} -- board attributes

	move_list: LIST[TUPLE [player: PLAYER; position: INTEGER; status: STRING]]	-- history of moves done
	player_one, player_two, next_player: PLAYER									-- players, next_player used for printing
	game_in_play: BOOLEAN														-- if false, undo and redo are not possible
	status_message: STRING														-- stores status message to output
	redo_allowed: BOOLEAN														-- allows redo operations
	game_won: BOOLEAN															-- checks if game won, used for undo and win condition/prompts

feature -- User Commands

	new_game (a_player_one_name: STRING; a_player_two_name: STRING)
--		Change player one and player two to new names, reset their wins
--		Clear the board, reset the pointer
		do
			player_one.change_name (a_player_one_name)
			player_one.reset_won
			player_two.change_name (a_player_two_name)
			player_two.reset_won
			game_in_play := true
			next_player := player_one
			status_flag(0)
		end

	play_again
		do
			move_list.start
			game_in_play := true
			redo_allowed := false
		end

	play (a_player_name: STRING; a_move: INTEGER)
--		Insert a new move into the move_list, assume defensive checks
		local
			current_player: PLAYER
			current_player_move: TUPLE[player: PLAYER; position: INTEGER; status: STRING]
		do
			current_player := get_player_with_name (a_player_name)

			if current_player ~ player_one then
				next_player := player_two
			else
				next_player := player_one
			end

			current_player_move := [current_player, a_move, "ok"]

			if move_list.count > move_list.index then
				move_list.forth
				move_list.replace (current_player_move)
			else
				move_list.force (current_player_move)
				move_list.forth
			end

			redo_allowed := false

--			check_for_win
		end

	undo
		do
			if move_list.index > 1 and game_in_play then
				move_list.back
				redo_allowed := true
				status_flag(0)
			end
		end

	redo
		do
			if redo_allowed and move_list.count >= move_list.index + 1 then
				move_list.forth
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
					i = move_list.index or stop
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
		do
			if move_list.count > move_list.index then
				Result := a_player_name ~ print_opponent (move_list.item.player)
			else
				Result := a_player_name ~ next_player.get_name
			end
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
			Result := not game_in_play and game_won = true
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
		move_list.forth
	end

feature	-- status message queries

	get_status_message: STRING
	do
		Result := status_message
	end

	get_previous_status_message: STRING
	do
		if move_list.index > 1 then
			Result := move_list[move_list.index - 1].status
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

	get_player_with_name (a_player_name: STRING): PLAYER
		do
			if player_one.get_name ~ a_player_name then
				Result := player_one
			else
				Result := player_two
			end
		end

	print_message: STRING
		do
			create Result.make_from_string ("")
			Result.append (": => ")
			if player_one.get_name ~ "" then
				Result.append ("start new game%N  ")
			elseif game_won = true then
				Result.append ("play again or start new game%N  ")
			else
				if move_list.item.status ~ "ok" then
					Result.append (print_opponent (move_list.item.player))
				else
					Result.append (next_player.get_name)
				end
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

			--DEBUG
--			Result.append ("%NCURRENT MOVE_LIST COUNT: ")
--			Result.append (move_list.count.out)
--			Result.append ("%NCURSOR INDEX: ")
--			Result.append (move_list.index.out)
--			Result.append (print_board_list)
		end

	print_board_list: STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			from
				i := 1
			until
				i > move_list.count
			loop
				Result.append ("%N---------------%NINDEX")
				Result.append (i.out)
				Result.append ("%N---------------%NPLAYER: ")
				Result.append (move_list.at (i).player.get_name)
				Result.append ("%NPIECE: ")
				Result.append (move_list.at (i).player.get_piece)
				Result.append ("%NPOSITION: ")
				Result.append (move_list.at (i).position.out)
				Result.append ("%N---------------")
				i := i + 1
			end
		end
	print_opponent (a_player: PLAYER): STRING
		do
			if a_player ~ player_one then
				Result := player_two.get_name
			else
				Result := player_one.get_name
			end
		end

	print_board: STRING
		local
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
				i > move_list.index
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

			if status_message /~ "" then
				Result.append (status_message)
			else
				Result.append (move_list.item.status)			-- fix this shit
			end

			Result.append (print_message)
			status_message := ""
		end

end




