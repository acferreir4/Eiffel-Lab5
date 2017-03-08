note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_piece: STRING; a_id: INTEGER)
			-- Initialization for `Current'.
		do
			name := a_name
			piece := a_piece
			id := a_id
			games_won := 0
		end

feature {PLAYER} -- Queries

	name: STRING
	games_won: INTEGER
	piece: STRING
	id: INTEGER

feature -- Commands

	win_game
		do
			games_won := games_won + 1
		end

	change_name (a_name: STRING)
		do
			name := a_name
		end

	reset_won
		do
			games_won := 0
		end

feature -- Queries

	get_id: INTEGER
		do
			Result := id
		end

	get_name: STRING
		do
			Result := name
		end

	get_piece: STRING
		do
			Result := piece
		end
end
