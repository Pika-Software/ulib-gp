---@meta

-- https://github.com/Srlion/Hook-Library/tree/master
PRE_HOOK = { -4 }
PRE_HOOK_RETURN = { -3 }
NORMAL_HOOK = { 0 }
POST_HOOK_RETURN = { 3 }
POST_HOOK = { 4 }

---@alias hook.Type
---| `PRE_HOOK`
---| `PRE_HOOK_RETURN`
---| `NORMAL_HOOK`
---| `POST_HOOK_RETURN`
---| `POST_HOOK`

--- [SHARED]
---
--- Registers a function (or "callback") with the Hook system so that it will be called automatically whenever a specific event (or "hook") occurs.
---
---@param event_name string The event to hook on to. This can be any GM hook, gameevent after using gameevent.Listen, or custom hook run with hook.Call or hook.Run.
---@param identifier string | any The identifier can be either a string, or a table/object with an IsValid function defined such as an Entity or Panel. numbers and booleans, for example, are not allowed.
---@param func function The function to be called, arguments given to it depend on the identifier used.
---@param priority hook.Type
---@diagnostic disable-next-line: redundant-parameter, duplicate-set-field
function hook.Add(event_name, identifier, func, priority)
end
