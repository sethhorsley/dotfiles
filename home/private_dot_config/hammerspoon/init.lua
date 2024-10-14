ev = hs.eventtap
	.new({ hs.eventtap.event.types.mouseMoved }, function(e)
		local sf = hs.screen.mainScreen():fullFrame()
		local loc = e:location()
		if loc.y < (sf.y + 1) and loc.y > (sf.y - 1) then
			return true
		else
			return false
		end
	end)
	:start()
