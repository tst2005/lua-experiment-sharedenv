
local FORCE_NIL = {} -- special uniq value to remember what is removed : do not restore the original value
local function newdualenv(ro, rw)
	rw = rw or {}

	local mt = {}
	mt.__index = function(_self, k)
		local v = rw[k]
		if v ~= nil then
			if v == FORCE_NIL then -- do not return the ro[k] value
				return nil
			end
			return v
		end
		return ro[k]
	end

	mt.__newindex = function(_self, k, v)
		if v == nil and ro[k] ~= nil then -- if the value was nil and something exists in the ro table
			rw[k] = FORCE_NIL -- remember the nil write with the special value
		else
			rw[k] = v
		end
	end
	mt.__metatable = false -- basic security, locking the metatable

	local t = setmetatable({}, mt)
	return t, rw
end
local M = {new = newdualenv}
setmetatable(M, {__call = function(_self, ...) return newdualenv(...) end})
return M
