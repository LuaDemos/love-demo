function restart_event(callbask)
  if love.keyboard.isDown("r") then
    callbask()
  end
end

return restart_event