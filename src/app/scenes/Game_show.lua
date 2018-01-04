
local Game_show = class("Game_show", function()
    return display.newScene("Game_show")
end)

function Game_show:ctor()
    self:show()
end

function Game_show:restart()
	local restart=cc.ui.UIPushButton.new({ normal = "btn/btn_000.png", pressed = "btn/btn_000.png" },{scale9 = true}) 
		:onButtonClicked(function()
			app:enterScene("Game_show", nil, "crossFade", 1.0)
		end)
    	:setButtonLabel("normal", cc.ui.UILabel.new({UILabelType = 2,text = "再来一局",size = 30,color=cc.c3b(100, 120, 130)})) 
    	:addTo(self)
    	:align(display.CENTER,display.cx+320,display.cy-230)
end

function Game_show:quit()
	local quit=cc.ui.UIPushButton.new({ normal = "btn/btn_000.png", pressed = "btn/btn_000.png" },{scale9 = true}) 
		:onButtonClicked(function()
			app:enterScene("MainScene", nil, "crossFade", 1.0)
		end)
    	:setButtonLabel("normal", cc.ui.UILabel.new({UILabelType = 2,text = "主菜单",size = 30,color=cc.c3b(100, 120, 130)})) 
    	:addTo(self)
    	:align(display.CENTER,display.cx+320,display.cy-130)
end

function Game_show:show()
	bgLayer = BgLayer.new()
		:addTo(self)
	cb_rec = Cb_rec.new()
	if (cb_rec.turn==0) then
	self.panel = display.newSprite("btn/btn_tab.png")
		:addTo(self)
		:pos(display.cx+320, display.cy+200)
		:setVisible(false)
	end
	self:restart()
	self:quit()
	bgLayer:setTouchEnabled(true)
	bgLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
		if(gamemode==1 and cb_rec.win==0)then
			local x,y=cb_rec:adjpos(event.x,event.y)
			local xx,yy=cb_rec:transtopos(x,y)
			--[[控制台调试:数组坐标显示
			print(event.x,event.y)
			print(x.."  "..y)
			print(xx.."  "..yy)
			--]]
			if (xx1~=-1 and yy~=-1 and cb_rec:enable(xx,yy)) then
				cb_rec.turn=cb_rec.turn+1
				self.panel:removeSelf()
				self:turn_info()
				if (cb_rec.turn%2==1) then
					cb_rec:record(xx,yy,1)
					display.newSprite("c_black.png")
    					:pos(x,y)
    					:addTo(self)
    			elseif(cb_rec.turn%2==0)then
    				cb_rec:record(xx,yy,2)
    				display.newSprite("c_white.png")
    					:pos(x,y)
    					:addTo(self)
				end
			end
			--胜负检测
			cb_rec:winchk()
		elseif(gamemode==2 and cb_rec.win==0)then
			local x,y=cb_rec:adjpos(event.x,event.y)
			local xx,yy=cb_rec:transtopos(x,y)
			--[[控制台调试:数组坐标显示
			print(event.x,event.y)
			print(x.."  "..y)
			print(xx.."  "..yy)
			--]]
			if (xx~=-1 and yy~=-1 and cb_rec:enable(xx,yy)) then
				cb_rec.turn=cb_rec.turn+1
				self.panel:removeSelf()
				self:turn_info()
				if (cb_rec.turn%2==1) then
					cb_rec:record(xx,yy,1)
					display.newSprite("c_black.png")
    					:pos(x,y)
    					:addTo(self)	
				end
				--胜负检测
				cb_rec:winchk()
				if (cb_rec.win==0) then
				cb_rec.turn=cb_rec.turn+1
				self.panel:removeSelf()
				self:turn_info()
				local xx2,yy2=cb_rec:simple_ai()
					print(cb_rec:simple_ai())
    				cb_rec:record(xx2,yy2,2)
    				display.newSprite("c_white.png")
    					:pos(cb_rec:numtopos(xx2,yy2))
    					:addTo(self)
    			end
			end
			--胜负检测
			cb_rec:winchk()
			if (cb_rec.win== 2) then
				cc.ui.UILabel.new({UILabelType = 2,text = "白棋赢！",size =90,color=cc.c3b(100, 120, 130)})
				:align(display.CENTER,display.cx, display.cy+120)
				:addTo(self)
			elseif (cb_rec.win== 1) then
				cc.ui.UILabel.new({UILabelType = 2,text = "黑棋赢！",size = 90,color=cc.c3b(100, 120, 130)})
				:align(display.CENTER,display.cx, display.cy+120)
				:addTo(self)
			end
		end
		cb_rec:show()
		
	end)
	
	
end

function Game_show:turn_info()
	self.panel = display.newSprite("btn/btn_tab.png")
		:addTo(self)
		:pos(display.cx+320, display.cy+200)
	local str=string.format("回合:"..cb_rec.turn)
	cc.ui.UILabel.new({UILabelType = 2,text = str,size = 34,color=cc.c3b(60, 120, 100)})
		:align(display.CENTER,display.cx+320, display.cy+200)
		:addTo(self)
end

function Game_show:onEnter()
end

function Game_show:onExit()
end

return Game_show
