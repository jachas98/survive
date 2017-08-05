-- Load player stats, after login
function playerLoadStats(player)
  -- get Every stats
  for _, data in pairs(player_stats_to_load) do
    playerLoadDataFromAccount(player, data[1], data[2])
  end
end

 -- Load player data from account
function playerLoadDataFromAccount(player, dataname, value)
  -- get Account
  local account = player:getAccount()
  -- set data
  playerSetData(player, dataname, account:getData(dataname) or value)
end

-- Save player stats, after logout
function playerSaveStats(account)
  -- Get every stat from table...
  for _, data in pairs(player_stats_to_load) do
    -- Get player position
    local position = source:getPosition()
    if data[1] == "pos_x" then
      -- Save position
      playerSaveDataToAccount(account, data[1], position.x)
    elseif data[1] == "pos_y" then
      -- Save position
      playerSaveDataToAccount(account, data[1], position.y)
    elseif data[1] == "pos_z" then
      -- Save position
      playerSaveDataToAccount(account, data[1], position.z)
    elseif data[1] == "skin" then
      -- Save skin
      playerSaveDataToAccount(account, data[1], source:getModel())
    else
      -- Save custom stats to db...
      playerSaveDataToAccount(account, data[1], playerGetData(source, data[1]))
    end
  end

end

-- Save data from account
function playerSaveDataToAccount(account, dataname, value)
  -- set data in player table.
  account:setData(dataname, value)
end

-- Get player data
function playerGetData(player, dataname)
  -- get data from player table
  return player:getData(dataname)
end

-- Set player data
function playerSetData(player, dataname, amount)
  -- Set data to amount
  player:setData(dataname, amount)
end

-- Add to player data
function playerAddData(player, dataname, amount)
  -- Add to player data amount
  player:setData(dataname, player:getData(dataname) + amount)
end

-- Subtrate from player data
function playerSubtData(player, dataname, amount)
  -- Check if subt number is less than 0
  if (player:getData(dataname) - amount < 0) then
    -- if subt is less than 0 then set his value to 0
    player:setData(dataname, 0)
  else
    -- subt data...
    player:setData(dataname, player:getData(dataname) - amount)
  end
end




function getDataCommand(player, cmd, arg1, arg2, arg3)
  if arg1 == "1" then
      outputChatBox(playerGetData(player, arg2), player)
  elseif arg1 == "2" then
      if arg3 then
        playerAddData(player, arg2, arg3)
      else
        outputChatBox("You need to input value.", player)
      end
  elseif arg1 == "3" then
      if arg3 then
        playerSubtData(player, arg2, arg3)
      else
        outputChatBox("You need to input value.", player)
      end
  elseif arg1 == "4" then
        outputChatBox(playerAccountGetData(player, arg2), player)
  elseif arg1 == "5" then
    for _, stat in pairs(player_stats_to_load) do
      playerSetData(player, stat[1], stat[2])
      setAccountData(getPlayerAccount(player), stat[1], stat[2])
      outputChatBox(stat[1], player)
    end
  else
      outputChatBox(player:getAccount():getData("blood"), player)
  end
end
addCommandHandler("data", getDataCommand)
