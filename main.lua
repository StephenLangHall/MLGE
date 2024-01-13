return {
  ["Main"]=function()
    Clear("black")
	  local Mex=10
	  local Mey=10
	  for n,v in pairs(base.Things) do
  		v.draw()
	  end
  end,
  ["Things"]={
	  ["Me"]={
		  ["x"]=10,
		  ["y"]=10,
		  ["draw"]=(function()
		  	local Mex=base.Things.Me.x
			  local Mey=base.Things.Me.y
			  draw.Rectangle(Mex, Mey, 2, 6, "white", 1)
			  draw.Pixel(Mex-1, Mey+2, "white")
			  draw.Pixel(Mex+3, Mey+2, "white")
			  draw.Pixel(Mex,   Mey+1, "green")
			  draw.Pixel(Mex+2, Mey+1, "green")
			  draw.Pixel(Mex,   Mey+7, "white")
			  draw.Pixel(Mex+2, Mey+7, "white")
		  end),
	  },
  },
}
