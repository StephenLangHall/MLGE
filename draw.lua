return {
Pixel = function(x,y,color)
  nx=x*3
  ny=y*3
  for xi=nx,(nx+2) do
    for yi=ny,(ny+2) do
      buffer:set_pixel(xi,yi,colors[color][1],colors[color][2],colors[color][3], colors[color][4])     
    end
  end
end,
Rectangle = function(x,y,w,h,color,fill)
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
end,
Clear = function(color)
  for x=0,xmax do
    for y=0,ymax do
      buffer:set_pixel(x,y,colors[color][1],colors[color][2],colors[color][3], colors[color][4])
    end
  end
end,
Line = function(sx,sy,ex,ey,color)
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
end,
}