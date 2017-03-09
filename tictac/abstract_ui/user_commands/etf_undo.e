note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			if model.get_previous_status_message /~ "name must start with A-Z or a-z" and
			   model.get_previous_status_message /~ "names of players must be different" then
				model.undo
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
