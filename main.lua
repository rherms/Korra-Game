widget = require("widget")
require("story")
math.randomseed( os.time() )
_W, _H = display.contentWidth, display.contentHeight
center_x = _W / 2
center_y = _H / 2
background = display.newImage("img/background.png", center_x, center_y - 100)
activeTimer = nil

local function setUpPanel()
	panel  = display.newRoundedRect(center_x, _H - 100, _W, 200, 12)
	panel:setFillColor(200, 0, 0)
	panel:setStrokeColor(0, 0, 0)
	panel.strokeWidth = 10
	upButton = display.newImage("img/up.png", 100, _H - 160)
	downButton = display.newImage("img/down.png", 100, _H - 40)
	leftButton = display.newImage("img/left.png", 50, _H - 100)
	rightButton = display.newImage("img/right.png", 150, _H - 100)
	rightButton:addEventListener( "touch", rightButton )
	leftButton:addEventListener( "touch", leftButton )
end

--levelsUnlocked = 9
--levelSelected = 0
curLevel = 1
curStory = 2 --reset to 1 when advance level
paused = false


korraSheet = graphics.newImageSheet("img/korraWalkSheet.png", {sheetContentWidth = 174, sheetContentHeight = 142, width = 43, height = 71, numFrames = 8})
korra = display.newSprite(korraSheet, {name = "korra", time = 500, start = 1, count = 8})
korra:setFrame(6)
korra.x = korra.width / 2
korra.y = _H - 200 - korra.height / 2 - 20

--create bottom panel
setUpPanel()

local function moveRight()
	if 	korra.x + 5 < _W - korra.width / 2 then
		korra.x = korra.x + 5
		if korra.frame == 8 then --this frame is weird
			korra.x = korra.x + 5
		end
	end
	local nextFrame = korra.frame + 1
	if nextFrame > 8 then
		nextFrame = 5
	end
	korra:setFrame(nextFrame)
end

function rightButton:touch(event)
	if event.phase == "began" then
		moveRight()
		activeTimer = timer.performWithDelay( 300, moveRight, 0 )
	elseif event.phase == "ended" then
		timer.cancel( activeTimer )
	end
end

function leftButton:touch(event)

end

composer = require "composer"
composer.recycleOnSceneChange = true
display.setStatusBar( display.HiddenStatusBar )
displayStory()
--composer.gotoScene("title", "fade", 400)