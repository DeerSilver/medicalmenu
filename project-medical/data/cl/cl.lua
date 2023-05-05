local display = false
local closestplayer = nil
local onduty = false

RegisterCommand('onduty', function(source, args)
    if args[1] == 'ems' and args[2] == 'password' then 
        onduty = not duty
    end

    if onduty then 
        TriggerEvent("gs-notify:SendNotification", "Information:", "You are now onduty as Medical Services!", 2000, "info")
    else 
        TriggerEvent("gs-notify:SendNotification", "Information:", "You are now off duty", 2000, "info")
    end
end)



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if onduty == true then 
            if IsControlJustPressed(0, 19) then
                SetDisplay(true)
            end
        end
    end
end)



RegisterNUICallback("display", function(data)
    SetDisplay(data.data)
    if data.data == false then 
        TriggerEvent("gs-notify:SendNotification", "Information:", "Exited", 2000, "info")
    end
end)

RegisterNUICallback("logged", function(data)
    if data.data == false then 
        if GetClosestPlayer() == false then 
            TriggerEvent("gs-notify:SendNotification", "Error:", "No patients where found to log", 5000, "error")
        else
            closestplayer = GetClosestPlayer()
            TriggerEvent("gs-notify:SendNotification", "Information:", "Patient Logged", 2000, "info")
        end
    end
end)

RegisterNUICallback("revive", function(data)
    SetDisplay(data.data)
    if data.data == false then 
        TriggerEvent("gs-notify:SendNotification", "Information:", "Patient Revived", 2000, "info")
    end
end)

RegisterNUICallback("hospitalize", function(data)
    SetDisplay(data.data)
    if data.data == false then 
        TriggerEvent("gs-notify:SendNotification", "Information:", "Patient Hospitalized", 2000, "info")
    end
end)

RegisterNUICallback("drag", function(data)
    SetDisplay(data.data)
    if data.data == false then 
        TriggerEvent("gs-notify:SendNotification", "Information:", "Dragging Patient", 2000, "info")
    end
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

-- some other stuff

--Dragging Event
local Drag = false
local OfficerDrag = -1
RegisterNetEvent('Drag')
AddEventHandler('Drag', function(ID)
	Drag = not Drag
	OfficerDrag = ID
	
	if not Drag then
        DetachEntity(PlayerPedId(), true, false)
	end
end)

--Drag Attachment
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if Drag then
            local Ped = GetPlayerPed(GetPlayerFromServerId(OfficerDrag))
            local Ped2 = PlayerPedId()
            AttachEntityToEntity(Ped2, Ped, 4103, 0.35, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            DisableControlAction(1, 140, true) --R
			DisableControlAction(1, 141, true) --Q
			DisableControlAction(1, 142, true) --LMB
        end
    end
end)










-- functions
function GetClosestPlayer()
    local Ped = PlayerPedId()

    for _, Player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(Player) ~= GetPlayerPed(-1) then
            local Ped2 = GetPlayerPed(Player)
            local x, y, z = table.unpack(GetEntityCoords(Ped))
            if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  2) then
                return GetPlayerServerId(Player)
            end
        end
    end
    return false
end