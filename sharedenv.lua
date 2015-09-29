local new = require "dualenv".new

-- the cache where we store the shared envs
local sharedenvs = {} -- FIXME: use weak table ?

local function envfor(modname, ro, sharedwith)
	local rw = sharedwith and sharedenvs[sharedwith]
	if rw then
		local t = new(ro, rw)
		sharedenvs[modname] = rw
		return t, rw, true
	end
	local t, rw = new(ro, nil)
	sharedenvs[modname] = rw
	return t, rw, false
end
local M = { new = envfor }
setmetatable(M, {__call = function(_self, ...) return envfor(...) end})
return M
