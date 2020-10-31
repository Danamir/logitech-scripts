function OnEvent(event, arg)
	-- Smart G Selector --
	--
	-- Handle gestures, short click, and long click actions with the G Selector button.
	-- Keep G Selector initial functionality.
	--
	-- Configure the smartButton variable to your assigned G Selector button, by default 6 is the "snipe" button.
	-- Create macros and alter the Left/Right/Up/Down/... PlayMacro("MacroName") sections of the code.
	-- Or write directly PressKey()/ReleaseKey() actions.

	-- Debug mode : if true does not perform any action --
	debug = false

	-- Smart button / G Selector --
	smartButton = 6  -- The button affected to G Selector in Logitech control panel (default 6 = "snipe" thubm button)
	
	smartButtonDeltaMin = 100  -- Minimum click time before registering a movement
	smartButtonDelta = 350  -- Time to register a long click
	smartButtonDistanceMin = 1000  -- Minimum distance to register a movement
	smartButtonDistanceMax = 20000  -- Maximum distance for a movement
	smartButtonMonitorRatio = 16/9  -- Monitor ratio

	if arg == smartButton then
		if event == "MOUSE_BUTTON_PRESSED" then
			GSelectorActive = true

			smartButtonStart = GetRunningTime()
			smartButtonDuration = nil
			smx1, smy1 = GetMousePosition()

			--OutputLogMessage("Mouse at: "..smx1..", "..smy1.."\n");
	
		elseif event == "MOUSE_BUTTON_RELEASED" then
			smartButtonDuration = GetRunningTime() - smartButtonStart
			smx2, smy2 = GetMousePosition()
			smxDelta = math.floor((smx2 - smx1) * smartButtonMonitorRatio)  -- Normalize delta X for 16:9 monitor
			smyDelta = smy2 - smy1
			smAngle = math.floor((math.atan2(smyDelta, smxDelta) * 180 / math.pi) * 10) / 10
			smDistance = math.floor(math.sqrt(math.pow(smxDelta, 2) + math.pow(smyDelta, 2)))

			if debug then
				OutputLogMessage("Mouse moved by: "..smxDelta..", "..smyDelta..". ");
				OutputLogMessage("Angle: ".. smAngle..", distance: "..smDistance..".\n")
			end

			if GSelectorAction then
				-- Do nothing: G Selector action already performed
				OutputLogMessage("Cancel action: G Selector action already performed \n")

			elseif smDistance > smartButtonDistanceMax then
				-- Do nothing: moved too far
				OutputLogMessage("Cancel action: Moved too far (".. smDistance .." > ".. smartButtonDistanceMax ..")\n")

			elseif smartButtonDuration < smartButtonDeltaMin or smDistance < smartButtonDistanceMin then
				-- Simple click
				if smartButtonDuration < smartButtonDeltaMin then
					OutputLogMessage("Short click (".. smartButtonDuration /1000 .."s < ".. smartButtonDeltaMin/1000 .."s) \n")
				elseif smDistance < smartButtonDistanceMin then
					OutputLogMessage("No movement (".. smDistance .." < ".. smartButtonDistanceMin ..")\n")
				end

				if smartButtonDuration < smartButtonDelta then
					-- Short click
					OutputLogMessage("Perform smart button short action \n")
					if not debug then
						PlayMacro("Play/pause")
					end
				else
					-- Long click
					OutputLogMessage("Perform smart button long action \n")
					if not debug then
						PlayMacro("Next track")
					end
				end

			elseif (180 >= smAngle and smAngle > 157.5) or (-157.5 > smAngle and smAngle >= -180)  then
				-- Left
				OutputLogMessage("Left \n")
				if not debug then
					PlayMacro("Send to previous monitor")
				end

			elseif 22.5 >= smAngle and smAngle > -22.5 then
				-- Right
				OutputLogMessage("Right \n")
				if not debug then
					PlayMacro("Send to next monitor")
				end

			elseif -67.5 >= smAngle and smAngle > -112.5 then
				-- Up
				OutputLogMessage("Up \n")
				if not debug then
					PressKey("escape")
					ReleaseKey("escape")
				end

			elseif 112.5 >= smAngle and smAngle > 67.5 then
				-- Down
				OutputLogMessage("Down \n")
				if not debug then
					PlayMacro("Minimize window")
				end

			elseif -112.5 >= smAngle and smAngle > -157.5 then
				-- Up Left
				OutputLogMessage("Up Left \n")
				if not debug then
					--PlayMacro("")
				end
			
			elseif -22.5 >= smAngle and smAngle > -67.5 then
				-- Up Right
				OutputLogMessage("Up Right \n")
				if not debug then
					--PlayMacro("")
				end

			elseif 157.5 >= smAngle and smAngle > 112.5 then
				-- Down Left
				OutputLogMessage("Down Left \n")
				if not debug then
					--PlayMacro("")
				end

			elseif 67.5 >= smAngle and smAngle > 22.5 then
				-- Donw Right
				OutputLogMessage("Down Right \n")
				if not debug then
					--PlayMacro("")
				end

			end

			GSelectorActive = false
			GSelectorAction = false
		end

		return
	end

	-- Capture other events --
	OutputLogMessage("Event: "..event.." Arg: "..arg.."\n");
	if GSelectorActive and (event == "MOUSE_BUTTON_PRESSED" or event == "MOUSE_BUTTON_RELEASED" ) then
		GSelectorAction = true
	end
end