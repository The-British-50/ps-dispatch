
local playAnim = false
local phoneProp = 0
local phoneModel = Config.PhoneModel


-- Item checks to return whether or not the client has a phone or not
local function HasPhone()
    return QBCore.Functions.HasItem("phone")
end


-- Loads the animdict so we can execute it on the ped
local function loadAnimDict(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function DeletePhone()
	if phoneProp ~= 0 then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end

local function NewPropWhoDis()
	DeletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Wait(1)
	end
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)

	local bone = GetPedBoneIndex(PlayerPedId(), 28422)
	if phoneModel == Config.PhoneModel then
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 15.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end
end

-- Does the actual animation of the animation when calling 999
local function PhoneCallAnim()
    loadAnimDict("cellphone@")
    local ped = PlayerPedId()
    CreateThread(function()
        NewPropWhoDis()
        playAnim = true
        while playAnim do
            if not IsEntityPlayingAnim(ped, "cellphone@", 'cellphone_text_to_call', 3) then
                TaskPlayAnim(ped, "cellphone@", 'cellphone_text_to_call', 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(100)
        end
    end)
end


-- Regular 999 call that goes straight to the Police
RegisterCommand('999', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    if string.len(msg) > 0 then
        if not exports['qb-policejob']:IsHandcuffed() then
            if HasPhone() then
                PhoneCallAnim()
                Wait(RandomNum(3,8) * 1000)
                playAnim = false
                local plyData = QBCore.Functions.GetPlayerData()
                local currentPos = GetEntityCoords(PlayerPedId())
                local locationInfo = getStreetandZone(currentPos)
                local gender = GetPedGender()
                TriggerServerEvent("dispatch:server:notify",{
                    dispatchcodename = "999call", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                    dispatchCode = "999",
                    firstStreet = locationInfo,
                    priority = 2, -- priority
                    name = plyData.charinfo.firstname:sub(1,1):upper()..plyData.charinfo.firstname:sub(2).. " ".. plyData.charinfo.lastname:sub(1,1):upper()..plyData.charinfo.lastname:sub(2),
                    number = plyData.charinfo.phone,
                    origin = {
                        x = currentPos.x,
                        y = currentPos.y,
                        z = currentPos.z
                    },
                    dispatchMessage = "Incoming Call", -- message
                    information = msg,
                    job = {"police", "ambulance"} -- jobs that will get the alerts
                })
                Wait(1000)
                DeletePhone()
                StopEntityAnim(PlayerPedId(), 'cellphone_text_to_call', "cellphone@", 3)
            else
                QBCore.Functions.Notify("You can't call without a Phone!", "error", 4500)
            end
        else
            QBCore.Functions.Notify("You can't call police while handcuffed!", "error", 4500)
        end
    else
        QBCore.Functions.Notify('Please put a reason after the 999', "success")
    end
end)

RegisterCommand('999a', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    if string.len(msg) > 0 then
        if not exports['qb-policejob']:IsHandcuffed() then
            if HasPhone() then
                PhoneCallAnim()
                Wait(RandomNum(3,8) * 1000)
                playAnim = false
                local plyData = QBCore.Functions.GetPlayerData()
                local currentPos = GetEntityCoords(PlayerPedId())
                local locationInfo = getStreetandZone(currentPos)
                local gender = GetPedGender()
                TriggerServerEvent("dispatch:server:notify",{
                    dispatchcodename = "999call", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                    dispatchCode = "999",
                    firstStreet = locationInfo,
                    priority = 2, -- priority
                    name = "Anonymous",
                    number = "Hidden Number",
                    origin = {
                        x = currentPos.x,
                        y = currentPos.y,
                        z = currentPos.z
                    },
                    dispatchMessage = "Incoming Anonymous Call", -- message
                    information = msg,
                    job = {"police", "ambulance"} -- jobs that will get the alerts
                })
                Wait(1000)
                DeletePhone()
                StopEntityAnim(PlayerPedId(), 'cellphone_text_to_call', "cellphone@", 3)
            else
                QBCore.Functions.Notify("You can't call without a Phone!", "error", 4500)
            end
        else
            QBCore.Functions.Notify("You can't call police while handcuffed!", "error", 4500)
        end
    else
        QBCore.Functions.Notify('Please put a reason after the 999', "success")
    end
end)

-- Regular 112 call that goes straight to the Police
RegisterCommand('112', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    if string.len(msg) > 0 then
        if not exports['qb-policejob']:IsHandcuffed() then
            if HasPhone() then
                PhoneCallAnim()
                Wait(RandomNum(3,8) * 1000)
                playAnim = false
                local plyData = QBCore.Functions.GetPlayerData()
                local currentPos = GetEntityCoords(PlayerPedId())
                local locationInfo = getStreetandZone(currentPos)
                local gender = GetPedGender()
                TriggerServerEvent("dispatch:server:notify",{
                    dispatchcodename = "112call", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                    dispatchCode = "112",
                    firstStreet = locationInfo,
                    priority = 2, -- priority
                    name = plyData.charinfo.firstname:sub(1,1):upper()..plyData.charinfo.firstname:sub(2).. " ".. plyData.charinfo.lastname:sub(1,1):upper()..plyData.charinfo.lastname:sub(2),
                    number = plyData.charinfo.phone,
                    origin = {
                        x = currentPos.x,
                        y = currentPos.y,
                        z = currentPos.z
                    },
                    dispatchMessage = "Incoming Call", -- message
                    information = msg,
                    job = {"police", "ambulance"} -- jobs that will get the alerts
                })
                Wait(1000)
                DeletePhone()
                StopEntityAnim(PlayerPedId(), 'cellphone_text_to_call', "cellphone@", 3)
            else
                QBCore.Functions.Notify("You can't call without a Phone!", "error", 4500)
            end
        else
            QBCore.Functions.Notify("You can't call police while handcuffed!", "error", 4500)
        end
    else
        QBCore.Functions.Notify('Please put a reason after the 999', "success")
    end
end)

-- Regular 112 call that goes straight to the Police
RegisterCommand('112a', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    if string.len(msg) > 0 then
        if not exports['qb-policejob']:IsHandcuffed() then
            if HasPhone() then
                PhoneCallAnim()
                Wait(RandomNum(3,8) * 1000)
                playAnim = false
                local plyData = QBCore.Functions.GetPlayerData()
                local currentPos = GetEntityCoords(PlayerPedId())
                local locationInfo = getStreetandZone(currentPos)
                local gender = GetPedGender()
                TriggerServerEvent("dispatch:server:notify",{
                    dispatchcodename = "112call", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                    dispatchCode = "112",
                    firstStreet = locationInfo,
                    priority = 2, -- priority
                    name = "Anonymous",
                    number = "Hidden Number",
                    origin = {
                        x = currentPos.x,
                        y = currentPos.y,
                        z = currentPos.z
                    },
                    dispatchMessage = "Incoming Call", -- message
                    information = msg,
                    job = {"police", "ambulance"} -- jobs that will get the alerts
                })
                Wait(1000)
                DeletePhone()
                StopEntityAnim(PlayerPedId(), 'cellphone_text_to_call', "cellphone@", 3)
            else
                QBCore.Functions.Notify("You can't call without a Phone!", "error", 4500)
            end
        else
            QBCore.Functions.Notify("You can't call police while handcuffed!", "error", 4500)
        end
    else
        QBCore.Functions.Notify('Please put a reason after the 999', "success")
    end
end)


Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/999', 'Send a message to the police.', {{ name="message", help="Message to police."}})
    TriggerEvent('chat:addSuggestion', '/999a', 'Send a message to the police anonymously.', {{ name="message", help="Message to police anonymous."}})
    TriggerEvent('chat:addSuggestion', '/112', 'Send a message to the EMS.', {{ name="message", help="Message to EMS."}})
    TriggerEvent('chat:addSuggestion', '/112a', 'Send a message to the EMS anonymously.', {{ name="message", help="Message to EMS anonymous."}})
end)
