
local scene = composer.newScene()
fullMessage = ""
text = {}
arrow = {}
done = false
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

function displayNextChar()
	if text.index <= string.len(fullMessage) then
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


local function advanceText()
	if not done then
		done = true
		text.text = fullMessage
		text.index = string.len(fullMessage)
	else
		arrow.isVisible = false
		print("next")
		--move on to next message
	end
end

-- "scene:create()"
function scene:create( event )
    local rect = display.newRoundedRect(center_x, _H - 100, _W, 200, 12)
	rect:setFillColor(0, 0, 200)
	rect:setStrokeColor(255, 255, 255)
	rect.strokeWidth = 10

	local head = display.newImage("img/asamiHead.png")
	head.x = _W - head.width / 2
	head.y = _H - head.height / 2


	rect:addEventListener("touch", advanceText)
	head:addEventListener("touch", advanceText)

	--400 characters max per message
	fullMessage = "Hi Korra! Ready to go explore the Spirit World? I am super excited this program is going very well let's see what else we can doHi Korra! Ready to go explore the Spirit World? I am super excited this program is going very well let's see what else we can doHi Korra! Ready to go explore the Spirit World? I am super excited this program is going very well let's see what else we can do"
	text = display.newText({text = "", x = center_x - 100, y = _H - 100, width = _W - 250, font = native.systemFontBold, fontSize = 20, align = "left"})
	text.index = 1 --for which character you are on	
	arrowX = head.x - head.width / 2 - 20
	arrowY = head.y + head.height / 2 - 50
	arrow = display.newPolygon(arrowX, arrowY, {arrowX, arrowY, arrowX + 20, arrowY, arrowX + 10, arrowY + 20})
	arrow.isVisible = false
	arrow.frames = 0
	Runtime:addEventListener( "enterFrame", displayNextChar )
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )

-- -------------------------------------------------------------------------------

return scene