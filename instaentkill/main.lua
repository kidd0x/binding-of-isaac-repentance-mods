local mod = RegisterMod("OneShotPoopsAndFires", 1)

local function OnEntityTakeDamage(entity, amount, damageFlags, damageSource, damageCountdownFrames)
    if entity:IsDead() then return end

    if entity.Type == EntityType.ENTITY_POOP then
        entity:Die()

    elseif entity.Type == EntityType.ENTITY_FIREPLACE then
        if entity.Variant == 1 then
            -- blue fire moare la hit: mai putine bombe de folosit :)
            if damageFlags & DamageFlag.DAMAGE_EXPLOSION > 0 then
                entity:Die()
            end
        else
            entity:Die()
        end
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, OnEntityTakeDamage)
