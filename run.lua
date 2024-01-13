package.cpath = package.cpath .. ";../?.so"
package.path = package.path .. ";../?.lua"

local lfb = require("lfb")
local fb = lfb.new_framebuffer("/dev/fb0")
local varinfo = fb:get_varinfo()
local buffer = lfb.new_drawbuffer(varinfo.xres, varinfo.yres)
local xmax = (varinfo.xres-1)
local ymax = (varinfo.yres-1)

base = require("main")
draw = require("draw")

os.execute("stty -icanon")
repeat
  base.Main()
  buffer:draw_to_framebuffer(fb, 0, 0)
  local KEY=io.read(1)
until "q"==KEY
os.execute("stty icanon")

fb:close()
