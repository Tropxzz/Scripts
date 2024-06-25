local ids = { -- you can put more Game ids in here if you like
    2753915549,
    4924922222,
    17017769292,
    10449761463,
    8737899170,
    920587237,
    15532962292,
    13775256536,
    185655149,
    17450551531,
    15101393044,
    8481844229,
    9872472334,
    13772394625, 
    13621938427,
    2768379856,
    7041939546, 
    13967668166,
    537413528, 
    8737602449,
    606849621,
    6403373529,
    12985361032,
    15002061926, -- gay blade ball copycat
    4580204640,
    6737970321,
    3351674303,
    13127800756,
    12355337193, -- pretend this is mm2
    4623386862,
    6516141723,
    1962086868,
    4639625707,
    16426795556, -- how do people actually play this
    286090429,
    192800,
    16288616721,
    5656754541,
    14566134687,
    6358567974,
    17495769916,
    17012548142,
    17390083917,
    6938803436,
    142823291,
    9049840490,
    11156779721,
    14184086618,
    8712817601
}

function IndexDictionary(dictionary,index)
	local i = 0
	for _,value in pairs(dictionary) do
		i=i+1
		if i == index then
			return value
		end
	end
end

function randomid()
    local meth = math.random(0, #ids)
    local index = IndexDictionary(ids, meth)
    return tostring(index)
end

local id = randomid()
local board = setclipboard or toclipboard or writeclipboard
if not board then
 game.Players.LocalPlayer:Kick("https://www.roblox.com/games/"..id.." | Is your game id since your executor doesnt support paste clipboard actions.")
else
board("https://www.roblox.com/games/"..id)
print(string.format(" %s / %s | Has been pasted into your clipboard", tostring(id), game:GetService("MarketplaceService"):GetProductInfo(id).Name))
end
