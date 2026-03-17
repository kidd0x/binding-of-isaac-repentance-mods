local mod = RegisterMod("OneShotPoopsAndFires", 1)
local game = Game()

local function OnEntityTakeDamage(_, entity, amount, damageFlags, damageSource, damageCountdownFrames)
    if entity.Type == EntityType.ENTITY_POOP or entity.Type == EntityType.ENTITY_FIREPLACE then
        if entity.Type == EntityType.ENTITY_FIREPLACE and entity.Variant == 1 then
            if damageFlags & DamageFlag.DAMAGE_EXPLOSION > 0 then
                entity:Die()
            end
        else
            if damageSource.Type == EntityType.ENTITY_TEAR or damageSource.Type == EntityType.ENTITY_KNIFE or damageSource.Type == EntityType.ENTITY_LASER then
                entity:Die()
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, OnEntityTakeDamage)
