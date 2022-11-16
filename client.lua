local time = 1000
function loadModel(model) 
    if not HasModelLoaded(model) then
        while not HasModelLoaded(model) do
            if time > 0 then time = time - 1 RequestModel(model)
            else time = 1000 break
            end
            Wait(10)
        end
    end 
end

function makeProp(data, freeze, synced)
    loadModel(data.prop)
    local prop = CreateObject(data.prop, data.coords.x, data.coords.y, data.coords.z-1.03, synced or 0, synced or 0, 0)
    SetEntityHeading(prop, data.coords.w-180.0)
    FreezeEntityPosition(prop, freeze or 0)
    return prop
end

CreateThread(function()
    for k, v in pairs(Config.RepairStations) do
        makeProp({coords = vector4(v.x, v.y, v.z, v.h), prop = v.name}, 1, 0)
    end
end)