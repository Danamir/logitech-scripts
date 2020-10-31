function OnEvent(event, arg)
	-- Media Button --
	--
	-- Short click "Play/pause" and long click "Next Track" actions.
	--
	-- Configure the mediaButton variable to an unassigned button, by default 7 is index lower button.
	-- Requires the creation of two macros "Play/pause" and "Next track" to launch system media actions.

	-- Debug mode : if true does not perform any action --
	debug = false

	-- Media button --
	mediaButton = 7  -- Disable this button in Logitech control panel (default 7 = index lower button)
	mediaButtonDelta = 350  -- Time to register a long click

	if arg == mediaButton then
		if event == "MOUSE_BUTTON_PRESSED" then
			mediaButtonStart = GetRunningTime()
			mediaButtonDuration = nil
	
		elseif event == "MOUSE_BUTTON_RELEASED" then
			mediaButtonDuration = GetRunningTime() - mediaButtonStart
	
			if mediaButtonDuration < mediaButtonDelta then
				-- Play/pause
				OutputLogMessage("Short click (".. mediaButtonDuration /1000 .."s) : Play \n")
				if not debug then
					PlayMacro("Play/pause")
				end
			else
				-- Next track
				OutputLogMessage("Long click (".. mediaButtonDuration /1000 .."s) : Next track \n")
				if not debug then
					PlayMacro("Next track")
				end
			end
		end

		return
	end

end