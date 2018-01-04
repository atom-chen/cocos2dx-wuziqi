
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newSprite("bg/bg_000.png")
    :pos(display.cx, display.cy)
    :addTo(self)
	cc.ui.UIPushButton.new({ normal = "btn/btn_menu01.png", pressed = "btn/btn_menu01.png" })
    	:onButtonClicked(function()
            --游戏模式2为ai
            gamemode=2
   	 		app:enterScene("Game_show", nil, "crossFade", 1.0)
   		end)
    	:align(display.CENTER,display.cx,display.cy-101)
    	:addTo(self)
        :setButtonLabel("normal", cc.ui.UILabel.new({UILabelType = 2,text = "AI模式",size = 34,color=cc.c3b(44, 88, 88)})) 

        local restart=cc.ui.UIPushButton.new({ normal = "btn/btn_menu01.png", pressed = "btn/btn_menu01.png" }) 
        :onButtonClicked(function()
            gamemode=1
            app:enterScene("Game_show", nil, "crossFade", 1.0)
        end)
        :setButtonLabel("normal", cc.ui.UILabel.new({UILabelType = 2,text = "自机双人",size = 34,color=cc.c3b(150, 170, 130)})) 
        :addTo(self)
        :align(display.CENTER,display.cx,display.cy-170)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
