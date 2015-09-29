
local FORCE_NIL = {}
local function newdualenv(ro, rw)
	rw = rw or {}

	local mt = {}
	mt.__index = function(_self, k)
		local v = rw[k]
		if v ~= nil then
			if v == FORCE_NIL then
				return nil
			end
			return v
		end
		return ro[k]
	end

	mt.__newindex = function(_self, k, v)
		if v == nil and ro[k] ~= nil then
			rw[k] = FORCE_NIL
		else
			rw[k] = v
		end
	end
	mt.__metatable = false -- locked

	local t = setmetatable({}, mt)
	return t, rw
end
local M = {new = newdualenv}
setmetatable(M, {__call = function(_self, ...) return newdualenv(...) end})
return M
