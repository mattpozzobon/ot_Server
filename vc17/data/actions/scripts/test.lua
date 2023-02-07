function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if player:getMana() > 5 then
	player:say(player:getMaxEnergy(), TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(15)
	player:setMaxEnergy(player:getMaxEnergy() + 5)
	player:say(player:getMaxEnergy(), TALKTYPE_MONSTER_SAY)
	else
	player:say("[OFF]", TALKTYPE_MONSTER_SAY)
	end

end
