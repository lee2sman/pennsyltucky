local gfx=love.graphics
local which=1 --test
local rotate_secs = 30 --how quickly to rotate once, in seconds
local timer_change = 1
local each_img = {}

function love.load()
  love.window.setFullscreen(true, "desktop")
  window_width = love.graphics.getWidth()
  window_height = love.graphics.getHeight()
  rand_x = love.math.random( window_width )
  rand_y = love.math.random( window_height)
  bg = gfx.newImage("bg.jpg")

  files = love.filesystem.getDirectoryItems( "assets" )
  img = {}
  for i = 1, #files do
    img[i]=gfx.newImage("assets/"..i..".png")
  end
  for i = 1,5 do
    each_img[i]={}
  end
  change_params()

  --music = love.audio.newSource("night-noises.mp3", "stream")
  music = love.audio.newSource("music.mp3", "stream")
  music:setLooping(true)
  music:play()
  love.graphics.setColor(1,1,1,0.5) --transparent background
end

function love.draw()
  local angle = love.timer.getTime() * math.rad(360) / rotate_secs
  --centered, spinning
  gfx.draw(bg, window_width/2,window_height/2,angle,1.2,1.2,bg:getWidth()/2,bg:getHeight()/2)
  local width  = img[which]:getWidth()
  local height = img[which]:getHeight()
  for i= 1,#each_img do

    love.graphics.setColor(1,1,1,each_img[i].a) 
    love.graphics.draw(img[each_img[i].n],each_img[i].x,each_img[i].y,love.timer.getTime() * math.rad(360) / each_img[i].t, 1, 1 , img[each_img[i].n]:getWidth()/2, img[each_img[i].n]:getHeight()/2)
  end

  if love.timer.getTime() > timer_change then
    change_params()
    timer_change=timer_change+math.random(2,5)
  end
end

function love.keypressed( key, scancode, isrepeat )
  change_params()
  if key == "escape" or key == "q" then return love.event.quit() end
end

function love.mousepressed()
  love.event.quit()
end

function change_params()
  for i = 1,#each_img do
    each_img[i].n=math.random(#files)
    each_img[i].x=love.math.random( window_width )
    each_img[i].y=love.math.random( window_height)
    each_img[i].t=math.random(20,60)
    each_img[i].a=math.random()
  end
end
