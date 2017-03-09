note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
create
	make
feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
    	do
			-- perform some update on the model state
			if not model.player_exists (player) then
				model.status_flag (4)
				model.invalid_command (model.get_status_message)
			elseif not model.is_their_turn (player) then
				model.status_flag (3)
				model.invalid_command (model.get_status_message)
			elseif not model.is_valid_move (press.as_integer_32) then
				model.status_flag (5)
				model.invalid_command (model.get_status_message)
			else
				model.play (player, press.as_integer_32)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
