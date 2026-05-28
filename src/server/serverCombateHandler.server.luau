local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SharedFolder = ReplicatedStorage:WaitForChild("Shared")

local CombatEvent = SharedFolder:WaitForChild("CombatEvent")

local playersPrevHitTime = {}

local CoolDownTime = 1
local damage = 10
local combatRange = 2.5

Players.PlayerAdded:Connect(function(player)

    playersPrevHitTime[player] = os.clock()

end)

Players.PlayerRemoving:Connect(function(player)

    playersPrevHitTime[player] = nil

end)

local function getClosestTarget(attacker)
    
    local attackerCharacter = attacker.Character
    local attackerHumanoidRootPart = attackerCharacter and attackerCharacter:FindFirstChild("HumanoidRootPart")
    print("getting closet player")
      for _, plr in pairs(Players:GetPlayers()) do
            
            --check distance
            --if in range take then take damage
            if plr ~= attacker then
                print("potential damager: "..plr.Name)
                local character = plr.Character
                local HumanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                local Humanoid = character and character:FindFirstChild("Humanoid")

                if Humanoid and HumanoidRootPart and Humanoid.Health > 0 then
                    print("can take damge: "..plr.Name)
                    local targetDistance = (attackerHumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                    print(targetDistance)
                    if targetDistance <= combatRange then
                        print(plr.Name.." is the one")
                       return Humanoid

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

    playersPrevHitTime[player] = currentTime 

end)