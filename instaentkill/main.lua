local mod = RegisterMod("OneShotPoopsAndFires", 1)
local game = Game()

local function OnEntityTakeDamage(_, entity, amount, damageFlags, damageSource, damageCountdownFrames)
    if entity.Type == EntityType.ENTITY_POOP or entity.Type == EntityType.ENTITY_FIREPLACE then
        if damageSource.Type == EntityType.ENTITY_TEAR then
            if entity.Type == EntityType.ENTITY_FIREPLACE and entity.Variant == 1 then
                return
            end
            entity:Die()
        end
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, OnEntityTakeDamage)
