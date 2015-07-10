fullMessage = ""
text = {}
arrow = {}
file = {}
rect = {}
done = false
head = {}

function displayNextChar()
	if not done and text.index <= string.len(fullMessage) then
		text.text = string.sub(fullMessage, 1, text.index)
		text.index = text.index + 1
	else
		done = true
		arrow.frames = arrow.frames + 1
		if arrow.frames % 10 == 0 then
			arrow.isVisible = not arrow.isVisible
		end
	end
end


local function advanceText(event)
	--otherwise it registers two events per tap
	if event.phase == "began" then
		if not done then
			done = true
			text.text = fullMessage
		else
			--move on to next message
			done = false
			text:removeSelf()
			head:removeSelf()
			arrow.isVisible = false
			arrow.frames = 0
			readLine()
		end
	end
end

function displayText()
	local index = string.find(fullMessage, ":")
	local charName = string.sub(fullMessage, 1, index - 1)
	fullMessage = string.sub(fullMessage, index + 1)

	--head pictures should be 200 pixels tall
	head = display.newImage("img/heads/" .. charName .. ".png")
	head.x = _W - head.width / 2
	head.y = _H - head.height / 2
	head:addEventListener("touch", advanceText)

	--400 characters max per message
	text = display.newText({text = "", x = center_x - 100, y = _H - 100, width = _W - 250, font = native.systemFontBold, fontSize = 20, align = "left"})
	text.index = 1 --for which character you are on	
end

function readLine()
	local line = file:read("*line")
	if line == nil then
		paused = false
		rect:removeSelf()
		arrow:removeSelf()
		Runtime:removeEventListener( "enterFrame", displayNextChar)
		file:close()
		return
	end
	fullMessage = line
	displayText()
end

function displayStory()
	paused = true
	fullMessage = ""
	text = {}
	file = {}
	rect = {}
	arrow = {}
	done = false
	local path = "C:/Users/rlher_000/Documents/Korra Game/levels/level" .. curLevel 
	file = assert(io.open(path .. "/story" .. curStory .. ".txt", "r"))

	rect = display.newRoundedRect(center_x, _H - 100, _W, 200, 12)
	rect:setFillColor(0, 0, 200)
	rect:setStrokeColor(255, 255, 255)
	rect.strokeWidth = 10
	rect:addEventListener("touch", advanceText)

	arrowX = _W - 200
	arrowY = _H - 50
	arrow = display.newPolygon(arrowX, arrowY, {arrowX, arrowY, arrowX + 20, arrowY, arrowX + 10, arrowY + 20})
	arrow.isVisible = false
	arrow.frames = 0

	Runtime:addEventListener("enterFrame", displayNextChar)
	readLine()
end