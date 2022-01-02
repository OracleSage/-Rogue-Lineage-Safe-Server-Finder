repeat wait() until game:IsLoaded()

syn.queue_on_teleport('loadstring(game:HttpGet("I_Need_The_Github_Link_First", true))()')

delay(30, function()
    game:GetService("TeleportService"):Teleport(3016661674)
end)

syn.queue_on_teleport()

local RAMAccount = loadstring(game:HttpGet'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMAccount.lua')()
local blockedSomeone = false
local MyAccount = RAMAccount.new(game:GetService'Players'.LocalPlayer.Name)
local blocked = MyAccount:GetBlockedList()
local epicstringyesomg = "Install ic3's" .. ' Roblox-Account-Manager AND add the current account to it\nAlso make sure to change "Enable Web Server" to "true" in "RamSettings.ini"'

if not MyAccount then 
    messagebox(epicstringyesomg,"https://github.com/ic3w0lf22/Roblox-Account-Manager",0)
    game:Shutdown()
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
    if usersBlocked[v] then blockedSomeone = true end
    if v ~= game.Players.LocalPlayer and blockedSomeone == false then
        local attempt = MyAccount:BlockUser(v)
        if game:GetService("HttpService"):JSONDecode(attmpt).success == true then
            blockedSomeone = true
        end
    end 
end


--]]
