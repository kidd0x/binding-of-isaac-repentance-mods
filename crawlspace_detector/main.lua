local mod = RegisterMod("CrawlSpaceDetector", 1)

local hasCrawlSpace = false

function mod:OnNewRoom()
    local room = Game():GetRoom()
    hasCrawlSpace = room:GetDungeonRockIdx() ~= -1
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoom)

function mod:OnRender()
    if not hasCrawlSpace then return end
    -- RenderText("String", x, y, r, g, b, a) daca vreti sa modificati ceva
    Isaac.RenderText("CRAWL SPACE", 208, 60, 255, 0, 0, 1)
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.OnRender)
