repeat wait() until game:IsLoaded()

if game.PlaceId == 3016661674 then
    syn.queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/OracleSage/-Rogue-Lineage-Safe-Server-Finder/main/USETHIS.lua", true))()')
    repeat wait() until false
end

local timeAtStart = os.clock()
local MaxHealthToBeAUltra = 140 --Change this to be the most health a player can have before the script considers them to be an ultra
local UltrasCanBeInServer = false --Set to true if you don't care and can gank the server out
local MaxPlayersOnAlert = 5 --Can be changed to any number seen fit, if you have UltrasCanBeInServer as true you should set this pretty high
local webhook = "https://discord.com/api/webhooks/927336223800979556/1bvVSJa03GNV8pliZFHNRsIUU2ib18uilVKJ7dUPHeObE-vGh4MSpN6Cws_v2zVK6AqJ" --Insert a webhook here for messages to be sent when a good server is found
local MaxAmountOfUltras = 0 --Can be set to negatives for example -1 to allow only one ultra
local HopServersEvenIfYouFoundASafe = false --Set to true if you want to find multiple servers ig

local RAMAccount = loadstring(game:HttpGet'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMAccount.lua')()
local blockedSomeone = false
local MyAccount = RAMAccount.new(game:GetService'Players'.LocalPlayer.Name)
local blocked = MyAccount:GetBlockedList()
local epicstringyesomg = "Install ic3's" .. ' Roblox-Account-Manager AND add the current account to it\nAlso make sure to change "Enable Web Server" to "true" in "RamSettings.ini"'
local safeServer = false

if not MyAccount then 
    messagebox(epicstringyesomg,"https://github.com/ic3w0lf22/Roblox-Account-Manager",0)
    game:Shutdown()
end

local function serverhop()
    if HopServersEvenIfYouFoundASafe == true or safeServer == false then
        syn.queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/OracleSage/-Rogue-Lineage-Safe-Server-Finder/main/USETHIS.lua", true))()')
        game:GetService("TeleportService"):Teleport(3016661674)
    end
end

ablocked = game:GetService("HttpService"):JSONDecode(blocked)
usersBlocked = ablocked.userList
totalBlocked = ablocked.total

writefile("OraleBlocked.txt", game:GetService("HttpService"):JSONEncode(usersBlocked))

if tonumber(totalBlocked) >= 100 then
    for i,v in pairs(usersBlocked) do
        if i <= 10 then
            MyAccount:UnblockUser(v)
            table.remove(usersBlocked, v)
        end
    end
end

for i,v in pairs(game.Players:GetChildren()) do
    if v.Character and v.Character.Humanoid.MaxHealth >= MaxHealthToBeAUltra then
        MaxAmountOfUltras = MaxAmountOfUltras + 1
    end
    if usersBlocked[v] then blockedSomeone = true end
    if v ~= game.Players.LocalPlayer and blockedSomeone == false then
        local attempt = MyAccount:BlockUser(v)
        if game:GetService("HttpService"):JSONDecode(attempt).success == true then
            blockedSomeone = true
        end
    end 
end

if #game.Players:GetPlayers() <= MaxPlayersOnAlert then
    if UltrasCanBeInServer == true or MaxAmountOfUltras <= 0 then
        safeServer = true
        local time = os.date("*t")
        time = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec) or "00:00:00"
        local server = "Roblox.GameLauncher.joinGameInstance(" .. game.PlaceId .. ",'" .. game.JobId .. "');"
        local JSONTable = {
	        ['embeds'] = {
	        	{
	        		['fields'] = {},
		        	['description'] = 'Put this in your browser, but put "javascript:" before it\n' .. server,
		        	['title'] = "Safe Server Found",
		        	['footer'] = {
		        		['text'] = time
		        	},
		        	['color'] = 5384145
	        	}
	        }
	    }
        syn.request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
	        Body = HTTP:JSONEncode(JSONTable)
        })
    end
end

local timeAfterRunning = os.clock()
local justInCase = 0

repeat task.wait(1) justInCase = justInCase + 1 until timeAfterRunning - timeAtStart >= 15 or justInCase >= 15

serverhop()
