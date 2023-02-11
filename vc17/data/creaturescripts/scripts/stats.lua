function onExtendedOpcode(player, opcode, buffer)
	local status, data = pcall(function()return json.decode(buffer)end)
    if not status then
        return false
    end
	
	
	-- code 1 = Server ? Client ? Info about player
	-- code 2 = Client > Server ? Info about player
	-- code 0 =
	-- code 5 = sending the points selected, (confirm button)
	
	if data.code == 1 then
		player:sendAnimatedText("code 1", TEXTCOLOR_BLUE);
		player:sendExtendedOpcode(100, json.encode(player:getAllStats(1)))
    end
	
	if data.code == 5 then
		player:sendAnimatedText("code 5", TEXTCOLOR_BLUE);
		
		if player:getPoints() >= data.points then
			player:setPoints(player:getPoints()-data.points)
			player:setDex(player:getDex() + data.dex)
			player:setInt(player:getInt() + data.int)
			player:setStr(player:getStr() + data.str)
			player:setCon(player:getCon() + data.con)
			player:setWis(player:getWis() + data.wis)
			player:setLuck(player:getLuck() + data.luck)
			player:sendExtendedOpcode(100, json.encode(player:getAllStats(1)))
		end
    end
	
	
end