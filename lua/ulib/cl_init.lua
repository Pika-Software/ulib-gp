ULib = ULib or {}

include( "ulib/shared/defines.lua" )
include( "ulib/shared/misc.lua" )
include( "ulib/shared/util.lua" )
include( "ulib/shared/tables.lua" )
include( "ulib/client/commands.lua" )
include( "ulib/shared/messages.lua" )
include( "ulib/shared/player.lua" )
include( "ulib/client/cl_util.lua" )
include( "ulib/client/draw.lua" )
include( "ulib/shared/commands.lua" )
include( "ulib/shared/sh_ucl.lua" )
include( "ulib/shared/plugin.lua" )
include( "ulib/shared/cami_global.lua" )
include( "ulib/shared/cami_ulib.lua" )

-- Shared modules
do
    local files = file.Find( "ulib/modules/*.lua", "LUA" )
    if #files > 0 then
        for _, file in ipairs( files ) do
            -- Msg( "[ULIB] Loading SHARED module: " .. file .. "\n" ) -- shut up
            include( "ulib/modules/" .. file )
        end
    end
end

-- Client modules
do
    local files = file.Find( "ulib/modules/client/*.lua", "LUA" )
    if #files > 0 then
        for _, file in ipairs( files ) do
            -- Msg( "[ULIB] Loading CLIENT module: " .. file .. "\n" ) -- shut up
            include( "ulib/modules/client/" .. file )
        end
    end
end

local needs_auth = {}

hook.Add( "OnEntityCreated", "ULibPlayerAuthCheck", function( ent )
    -- Listen for player creations
    if ent:IsPlayer() and needs_auth[ ent:UserID() ] then
        hook.Call( ULib.HOOK_UCLAUTH, nil, ent ) -- Because otherwise the server might call this before the player is created
        needs_auth[ ent:UserID() ] = nil
    end
end, PRE_HOOK )

-- Flag server when LocalPlayer() should be valid
hook.Add( "InitPostEntity", "ULibLocalPlayerReady", function()
    local pl = LocalPlayer()
    if pl and pl:IsValid() then
        hook.Call( ULib.HOOK_LOCALPLAYERREADY, nil, pl )
        RunConsoleCommand( "ulib_cl_ready" )
    end
end, PRE_HOOK )

-- We're trying to make sure that the player auths after the player object is created, this function is part of that check
function _G.authPlayerIfReady( ply, userid )
    if ply and ply:IsValid() then
        hook.Call( ULib.HOOK_UCLAUTH, nil, ply ) -- Call hook
    else
        needs_auth[ userid ] = true
    end
end
