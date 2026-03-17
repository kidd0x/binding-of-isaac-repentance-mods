local mod = RegisterMod("CrawlSpaceDetector", 1)
 
local hasCrawlSpace = false
 
-- Fonturi disponibile in joc:
-- "font/terminus.fnt"       
-- "font/pftempestaseven.fnt"
-- "font/upheaval.fnt"       
-- "font/teammeatfont10.fnt" 
-- https://wofsauge.github.io/IsaacDocs/rep/tutorials/Tutorial-Rendertext.html?h=rendertext#example-code
local font = Font()
font:Load("font/teammeatfont10.fnt")
 
function mod:OnNewRoom()
    local room = Game():GetRoom()
    hasCrawlSpace = room:GetDungeonRockIdx() ~= -1
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoom)
 
function mod:OnRender()
    if not hasCrawlSpace then return end
    -- DrawString(str, x, y, KColor, boxWidth, center)
    -- KColor(r, g, b, a) - valori 0-1
    -- boxWidth 0 = no wrap
    -- center true = fixat pe x
    font:DrawString("CRAWL SPACE", 200, 60, KColor(1, 0, 0, 1), 0, false)
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.OnRender)
 
