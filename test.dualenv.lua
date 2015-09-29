local new = require "dualenv".new

local t = new(_G)

t.aa = 1
assert(t.aa==1)

assert(t.print == _G.print) -- t.print exists it's _G.print
-- we overwrite the t.print value by a simple function
t.print = function() return "p" end
assert( t.print() == "p" ) -- the new print function return the "p" value

-- we remove the print function
t.print=nil

assert(t.print == nil) -- the t.print is nil, not restored to _G.print

t.print=false -- the t.print is false, not restored to _G.print
assert(t.print == false)

assert( _G.print) -- _G.print is still exists.
