local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SharedFolder = ReplicatedStorage:WaitForChild("Shared")

local CombatEvent = SharedFolder:WaitForChild("CombatEvent")

local DAMAGE_RANGE = 10
local DAMAGE_COOLDOWN = 1
local DAMAGE = 10

local serverPlayersPrevHitTime = {}

Players.PlayerAdded:Connect(function(player)

    serverPlayersPrevHitTime[player] = 0

end)

Players.PlayerRemoving:Connect(function(player)

    serverPlayersPrevHitTime[player] = nil

end)

CombatEvent.OnServerEvent:Connect(function(player)

    local character = player.Character
    local Humanoid = character and character:FindFirstChild("Humanoid")
    local HumanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    local closestTargetHumanoid = nil
    local closestTargetDistance = nil

    local currentTime = os.clock()

    local prevHitTime = serverPlayersPrevHitTime[player] or 0

    if currentTime - prevHitTime < DAMAGE_COOLDOWN then
        return
    end

    if HumanoidRootPart and Humanoid and Humanoid.Health > 0 then
        print("Attacker is alive")
        for _, potentialTarget in pairs(Players:GetPlayers()) do
            
            if potentialTarget == player then
                continue
            end

            local potentialTargetCharacter = potentialTarget.Character
            local potentialTargetHumanoid = potentialTargetCharacter and potentialTargetCharacter:FindFirstChild("Humanoid")
            local potentialTargetHumanoidRootPart = potentialTargetCharacter and potentialTargetCharacter:FindFirstChild("HumanoidRootPart")
            
            if potentialTargetHumanoid and potentialTargetHumanoidRootPart and potentialTargetHumanoid.Health > 0 then
              
                local targetDistance = (HumanoidRootPart.Position - potentialTargetHumanoidRootPart.Position).Magnitude

                if targetDistance <= DAMAGE_RANGE then
                   
                    if not closestTargetDistance then
                     
                        closestTargetDistance = targetDistance
                        closestTargetHumanoid = potentialTargetHumanoid

                    else
                     
                        if targetDistance < closestTargetDistance then
                         
                            closestTargetDistance = targetDistance
                            closestTargetHumanoid = potentialTargetHumanoid

                        end

                    end

                end

            end

        end

        if closestTargetHumanoid then
            closestTargetHumanoid:TakeDamage(DAMAGE)
        end


        serverPlayersPrevHitTime[player] = currentTime

    end



end)