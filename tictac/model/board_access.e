note
	description: "Singleton access to the default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	BOARD_ACCESS

feature
	m: BOARD
		once
			create Result.make
		end

invariant
	m = m
end




