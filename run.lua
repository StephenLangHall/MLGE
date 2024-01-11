package.cpath = package.cpath .. ";../?.so"
package.path = package.path .. ";../?.lua"

local lfb = require("lfb")
local fb = lfb.new_framebuffer("/dev/fb0")
local varinfo = fb:get_varinfo()
local buffer = lfb.new_drawbuffer(varinfo.xres, varinfo.yres)
local xmax = (varinfo.xres-1)
local ymax = (varinfo.yres-1)

colors = {
--             red  blue green alpha
  ["red"]=   { 255, 0,   0,    255 },
  ["green"]= { 0,   0,   255,  255 },
  ["blue"]=  { 0,   255, 0,    255 },
  ["black"]= { 0,   0,   0,    255 },
  ["white"]= { 255, 255, 255,  255 },
}

function Pixel(x,y,color)
  nx=x*3
  ny=y*3
  for xi=nx,(nx+2) do
    for yi=ny,(ny+2) do
      buffer:set_pixel(xi,yi,colors[color][1],colors[color][2],colors[color][3], colors[color][4])     
    end
  end
end

function Rectangle(x,y,w,h,color,fill)
  if fill==0 then
    for i=x,(x+w) do
      Pixel(i,y,color)
      Pixel(i,(y+h),color)
    end
    for i=y,(y+h) do
      Pixel(x,i,color)
      Pixel((x+w),i,color)
    end
  else
    for xi=x,(x+w) do
      for yi=y,(y+h) do
        Pixel(xi,yi,color)
      end
    end
  end
end

function Clear(color)
  for x=0,xmax do
    for y=0,ymax do
      buffer:set_pixel(x,y,colors[color][1],colors[color][2],colors[color][3], colors[color][4])
    end
  end
end

function Line(sx,sy,ex,ey,color)
  local dx = sx-ex
  local dy = sy-ey
  local steps = 0
  local x=0
  local y=0
  if dx>dy then
    steps=dx
  else
    steps=dy
  end
  local xinc = dx / steps
  local yinc = dy / steps
  local i=0
  while i<steps do
    i=i+1
    x=x+xinc
    y=y+yinc
    Pixel(math.floor(x),math.floor(y),color)
  end
end

Things={
	["Me"]={
		["x"]=10,
		["y"]=10,
		["draw"]=(function()
			local Mex=Things.Me.x
			local Mey=Things.Me.y
			Rectangle(Mex, Mey, 2, 6, "white", 1)
			Pixel(Mex-1, Mey+2, "white")
			Pixel(Mex+3, Mey+2, "white")
			Pixel(Mex,   Mey+1, "green")
			Pixel(Mex+2, Mey+1, "green")
			Pixel(Mex,   Mey+7, "white")
			Pixel(Mex+2, Mey+7, "white")
		end),
	}
}

os.execute("stty -icanon")
repeat
  Clear("black")
	local Mex=10
	local Mey=10
	for n,v in pairs(Things) do
		v.draw()
	end
  buffer:draw_to_framebuffer(fb, 0, 0)
  local KEY=io.read(1)
until "q"==KEY
os.execute("stty icanon")

fb:close()
