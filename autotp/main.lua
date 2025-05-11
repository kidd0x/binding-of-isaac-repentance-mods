local AutoTeleport = RegisterMod("Auto Teleport to Rooms", 1)
local game = Game()
local level = game:GetLevel()
local teleportDone = false

local ITEM_ROOM = RoomType.ROOM_TREASURE
local PLANETARIUM = RoomType.ROOM_PLANETARIUM

local function teleportToRoom(roomType)
    local roomIndex = -1
    local stageRooms = level:GetRooms()

    for i = 0, stageRooms.Size - 1 do
        local desc = stageRooms:Get(i)
        if desc and desc.Data and desc.Data.Type == roomType then
            roomIndex = desc.SafeGridIndex
            break
        end
    end

    if roomIndex ~= -1 then
        game:StartRoomTransition(roomIndex, Direction.NO_DIRECTION, RoomTransitionAnim.FADE)
        teleportDone = true
    end
end

-- Reset flag on new floor
function AutoTeleport:OnNewLevel()
    teleportDone = false
end

AutoTeleport:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, AutoTeleport.OnNewLevel)

-- Try auto-teleport on first room of floor
function AutoTeleport:OnNewRoom()
    if not teleportDone and game:GetFrameCount() <= 1 then
        teleportToRoom(ITEM_ROOM)
        if not teleportDone then
            teleportToRoom(PLANETARIUM)
        end
    end
end

AutoTeleport:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, AutoTeleport.OnNewRoom)

-- Manual key-based trigger
function AutoTeleport:onInputAction(_, inputHook, button, _)
    if inputHook == InputHook.IS_ACTION_PRESSED then
        local isTabR = Input.IsButtonPressed(Keyboard.KEY_TAB, 0) and Input.IsButtonPressed(Keyboard.KEY_R, 0)
        local isHoldingR = Input.IsButtonPressed(Keyboard.KEY_R, 0)

        if (isTabR or isHoldingR) and not teleportDone then
            teleportToRoom(ITEM_ROOM)
            if not teleportDone then
                teleportToRoom(PLANETARIUM)
            end
        end
    end
end

AutoTeleport:AddCallback(ModCallbacks.MC_INPUT_ACTION, AutoTeleport.onInputAction)
