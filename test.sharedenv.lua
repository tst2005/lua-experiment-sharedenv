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
-- rw[123] and s[123] are used for debug/test

assert( rw1 == rw2 )
assert( rw2 ~= rw3 )


-- the sandboxes will use the t[123] as virtual _G env

-- each env are different
assert( t1 ~= t2 and t2 ~= t3)

-- When you write something in t1 ...
t1.aa = 123

-- ... it was shared on t2 ...
assert(t2.aa == 123)

-- ... but not on t3.
assert(t3.aa == nil)

-- all t1/t2/t3 have the same print function (coming from the native _G.print)
assert( t1.print == t2.print and t2.print == t3.print)

-- but we should overwrite it
t1.print = function() return "no print!" end
assert(t1.print == t2.print) -- it was shared with t2
assert(t3.print == _G.print) -- but t3.print still the native one

t3.print = nil -- but we should also drop it
assert(t3.print == nil)
assert( type(_G.print) == "function") -- the native one still exists.

assert( type(t1.print) == "function" )
assert( t2.print() == "no print!")





