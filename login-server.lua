function onPlayerJoinHandler()
  outputChatBox("Witaj na serwerze survival!")
  outputChatBox("Zaloguj się aby wpełni korzystać z systemu!")
end
addEventHandler("onPlayerJoin", getRootElement(), onPlayerJoinHandler)

function onPlayerLoginHandler()
  playerLoadStats(source)
  source:setHudComponentVisible("all", false)
  source:spawn(playerGetData(source, "pos_x"), playerGetData(source, "pos_y"), playerGetData(source, "pos_z"))
  source:setModel(playerGetData(source, "skin"))
  source:fadeCamera(true)
  source:setCameraTarget(source)
end
addEventHandler("onPlayerLogin", getRootElement(), onPlayerLoginHandler)

function onPlayerLeaveHandler(account)
  playerSaveStats(account)
end
addEventHandler ( "onPlayerLogout", getRootElement(), onPlayerLeaveHandler )
