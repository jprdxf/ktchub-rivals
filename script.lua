

-- Función para obtener el jugador más cercano
local function getNearestPlayer()
    local players = game:GetService("Players"):GetPlayers()
    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(players) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

-- Función para apuntar al jugador
local function aimAtPlayer(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = player.Character.HumanoidRootPart.Position
        local camera = game.Workspace.CurrentCamera
        local ray = Ray.new(camera.CFrame.Position, (targetPosition - camera.CFrame.Position).unit * 1000)
        local hit, position = workspace:FindPartOnRay(ray, camera)

        if hit then
            camera.CFrame = CFrame.new(camera.CFrame.Position, position)
        end
    end
end

-- Función para disparar
local function shoot()
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

-- Bucle principal
local function mainLoop()
    while true do
        local nearestPlayer = getNearestPlayer()
        if nearestPlayer then
            aimAtPlayer(nearestPlayer)
            shoot()
        end
        wait(0.1) -- Ajusta este valor para cambiar la frecuencia de actualización
    end
end

-- Iniciar el bucle principal
mainLoop()
