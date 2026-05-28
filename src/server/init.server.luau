local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SharedFolder = ReplicatedStorage:WaitForChild("Shared")

local CombatEvent = SharedFolder:WaitForChild("CombatEvent")

local playersPrevHitTime = {}

local CoolDownTime = 0.5
local damage = 10
local combatRange = 10

local function takeDamage(player)

    --character , HumanoidRootPart, Humanoid

    local character = player.Character
    local HumanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local Humanoid = chracter and chracter:FindFirstChild("Humanoid")

    if Humanoid and HumanoidRootPart and Humanoid.Health > 0 then

        Humanoid:TakeDamage(damage)

    end

end

local function getClosestTarget(attacker)

    local attackerCharacter = attacker.Chracter
    local attackerHumanoidRootPart = attackerCharacter and attackerCharacter:FindFirstChild("HumanoidRootPart")

      for _, plr in pairs(Players:GetPlayers()) do

            --check distance
            --if in range take then take damage
            if plr ~= attacker then

                local character = plr.Character
                local HumanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                local Humanoid = chracter and chracter:FindFirstChild("Humanoid")

                if Humanoid and HumanoidRootPart and Humanoid.Health > 0 then

                    local targetDistance = (attacterkerHumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude

                    if targetDistance <= combatRange then

                       return plr

                    end

                end

            end
            

        end

    
end

CombatEvent.OnServerEvent:Connect(function(player)

    local currentTime = os.clock()
    
    if currentTime - playersPrevHitTime[player] < CoolDownTime then

        return
      
    end

    local targetHumanoid = getClosestTarget(player) 

    if targetHumanoid then

        targetHumanoid:TakeDamage(damage)

    end

    playerPrevHitTime[player] = currentTime 

end)