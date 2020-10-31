# logitech-scripts
LUA scripts for Logitech G series

Written for the G502 Hero, but should work with all Logitech G series. The scripts can be customized to launch any of your local macros.

## How to find a button value

Launch a default empty script and watch the result of the `OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")` action.  
`arg` is the value that should be assigned to the button variables when configuring the code.

## Smart G Selector

Handle gestures, short click, and long click actions with the G Selector button.  
Keep G Selector initial functionality.
	
Configure the smartButton variable to your assigned G Selector button, by default 6 is the "snipe" button.
Set `smartButton8Way` to `true` to enable 8-way gestures with narrower directions, by default handle 4-way gestures. 
Create macros and alter the Left/Right/Up/Down/... `PlayMacro("MacroName")` sections of the code.  
Or write directly `PressKey()` and `ReleaseKey()` actions.


## Media button

Short click "Play/pause" and long click "Next Track" actions.

Configure the mediaButton variable to an unassigned button, by default 7 is index lower button.  
Requires the creation of two macros "Play/pause" and "Next track" to launch system media actions.