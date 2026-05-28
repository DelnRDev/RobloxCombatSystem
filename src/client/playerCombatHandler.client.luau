local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedFolder = ReplicatedStorage:WaitForChild("Shared")

local CombatEvent = SharedFolder:WaitForChild("CombatEvent")


UserInputService.InputBegan:Connect(function(input, gameProcessed)

    if gameProcessed then
        return
    end 

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        CombatEvent:FireServer()
    end

end)