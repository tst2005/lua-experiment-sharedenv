local new = require "sharedenv".new

-- very basic cross sharing config
local config = {
	mod1 = "mod2", -- shared with mod2
	mod2 = "mod1", -- shared with mod1
	mod3 = false -- not shared
}

local t1, rw1, s1 = new("mod1", _G, config["mod1"])
local t2, rw2, s2 = new("mod2", _G, config["mod2"])
local t3, rw3, s3 = new("mod3", _G, config["mod3"])

assert( rw1 == rw2 )
assert( rw2 ~= rw3 )

assert( t1 ~= t2 and t2 ~= t3)

t1.aa = 123
assert(t2.aa == 123)

assert(t3.aa == nil)



