function onLogin(player)
	local serverName = configManager.getString(configKeys.SERVER_NAME)
	local loginStr = "Welcome to " .. serverName .. "!"
	
	if player:getStorageValue(85908) ~= 10 then
		player:setStorageValue(85908, 10)
		player:setStorageValue(10000, 100) -- Points
		player:setStorageValue(10100, 0) -- str
		player:setStorageValue(10101, 0) -- dex
		player:setStorageValue(10102, 0) -- int
		player:setStorageValue(10103, 0) -- con
		player:setStorageValue(10104, 0) -- wis
		player:setStorageValue(10105, 0) -- luck
	
	end
	
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit in %s: %s.", serverName, os.date("%d %b %Y %X", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(PlayerStorageKeys.promotion)
		if value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	player:registerEvent("Stats")
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("FirstLogin")
	
	
	return true
end
