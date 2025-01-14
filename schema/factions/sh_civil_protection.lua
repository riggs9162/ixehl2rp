FACTION.name = "Civil Protection"
FACTION.description = "The Civil Protection Force of the Universal Union."
FACTION.color = Color(20, 120, 185)
FACTION.abbreviation = "CP"

FACTION.models = {
	"models/ez2npc/police.mdl"
}

FACTION.skin = 1

ix.anim.SetModelClass("models/ez2npc/police.mdl", "metrocop")

FACTION.taglines = {
	"union",
    "defender",
    "hero",
    "jury",
    "king",
    "line",
    "quick",
    "roller",
    "stick",
    "tap",
    "victor",
	"xray"
}

player_manager.AddValidModel("ixCPF", "models/ez2npc/police.mdl")
player_manager.AddValidHands("ixCPF", "models/weapons/c_metrocop_hands.mdl", 0, "00000000")

function FACTION:GetDefaultName(ply)
	return "CP:RCT:" .. string.upper(self.taglines[math.random(1, #self.taglines)]) .. ":" .. Schema:ZeroNumber(math.random(100, 999), 3), true
end

function FACTION:ModifyPlayerStep(ply, data)
	if ( data.ladder or data.submerged ) then
		return
	end

	local extraSounds = {}

	data.snd = string.Replace(data.snd, ".stepright", "")
	data.snd = string.Replace(data.snd, ".stepleft", "")

	for i = 1, 4 do
		extraSounds[#extraSounds + 1] = "player/footsteps/" .. data.snd .. i .. ".wav"
	end

	for _, v in ipairs(extraSounds) do
		EmitSound(v, ply:GetPos(), ply:EntIndex(), CHAN_AUTO, data.volume * (data.running and 0.5 or 0.4))
	end

	data.snd = "npc/metropolice/gear" .. math.random(1, 4) .. ".wav"
	data.volume = data.volume * (data.running and 0.5 or 0.4)
end

FACTION_CP = FACTION.index