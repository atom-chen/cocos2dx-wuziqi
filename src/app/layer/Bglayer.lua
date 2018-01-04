BgLayer = class("BgLayer",function()

    return display.newLayer()

end)



function BgLayer:ctor()
	display.newSprite("bg/bg_002.png")
    :pos(display.cx, display.cy)
    :addTo(self)
    display.newSprite("c_bp.png")
    :pos(400, 400)
    :addTo(self)

end



return BgLayer