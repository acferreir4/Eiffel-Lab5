note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY_AGAIN
inherit
	ETF_PLAY_AGAIN_INTERFACE
		redefine play_again end
create
	make
feature -- command
	play_again
    	do
			-- perform some update on the model state
			if model.play_again_allowed then
				model.play_again
			else
				model.status_flag (7)
				model.invalid_command (model.get_status_message)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
