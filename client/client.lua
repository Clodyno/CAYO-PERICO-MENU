ESX = exports.es_extended:getSharedObject()

Citizen.CreateThread(function()

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
    --RefreshMoney()
end)

Citizen.CreateThread(function()
  local ped_hash = GetHashKey("cs_martinmadrazo")
  RequestModel(ped_hash)
  while not HasModelLoaded(ped_hash) do
      Citizen.Wait(1)
  end	
  NPC1 = CreatePed(1, ped_hash, 4504.1802, -4553.6841, 3.1719, 18.5388, false, true)
  SetBlockingOfNonTemporaryEvents(NPC1, true)
  SetPedDiesWhenInjured(NPC1, false)
  SetPedCanPlayAmbientAnims(NPC1, true)
  SetPedCanRagdollFromPlayerImpact(NPC1, false)
  SetEntityInvincible(NPC1, true)
  FreezeEntityPosition(NPC1, true)
end)

  exports.qtarget:AddTargetModel({`cs_martinmadrazo`}, {
    options = {
      {
        icon = "fas fa-cash",
        label = "Pulisci Soldi",  
        action = function(entity)
          TriggerEvent('kalash:clodyno:pulizia:target')
        end
      },
      {
        icon = "fas fa-leaf",
        label = "Vendi Droga",  
        action = function(entity)
          TriggerEvent('kalash:clodyno:droga:target')
        end
      }
    },
    distance = 2
  })

RegisterNetEvent('kalash:clodyno:pulizia:target')
AddEventHandler('kalash:clodyno:pulizia:target', function()
  ESX.PlayerData = ESX.GetPlayerData()
  if ESX.PlayerData.job.grade_name == 'boss' then
    MenuPulizia()
  else
    ESX.ShowNotification('Non hai i permessi!')
  end
end)

function MenuPulizia()
  local elementi = {
		{icon = 'fas fa-info-circle', label = '100K PER VOLTA, CONTINUARE?', value = 'continuare'},
    {icon = 'fas fa-info-circle', label = '100K PER VOLTA, SMETTERE?', value = 'smettere'},
	}

  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title    = 'PULIZIA SOLDI',
		align    = 'top-left',
		elements = elementi
		}, function(data, menu)
		if data.current.value == 'continuare' then
			TriggerServerEvent('kalash:clodyno:pulizia:ritiro')
			menu.close()
		elseif data.current.value == 'smettere' then
        menu.close()
        ESX.ShowNotification('Hai annullato la pulizia dei soldi')
    end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('kalash:clodyno:droga:target')
AddEventHandler('kalash:clodyno:droga:target', function()
  ESX.PlayerData = ESX.GetPlayerData()
  if ESX.PlayerData.job.grade_name == 'boss' then
    MenuDrogaSoldiScelta()
  else
    ESX.ShowNotification('Non hai i permessi!')
  end
end)

function MenuDrogaSoldiScelta()
  local elementi = {
		{icon = 'fas fa-info-circle', label = 'SOLDI PULITI', value = 'puliti'},
    {icon = 'fas fa-info-circle', label = 'SOLDI SPORCHI', value = 'sporchi'},
	}

  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title    = 'VENDITA DROGA',
		align    = 'top-left',
		elements = elementi
		}, function(data, menu)
		if data.current.value == 'puliti' then
      ESX.ShowNotification('Riceverai soldi puliti')
			menu.close()
      MenuDrogaSoldiPuliti()
		elseif data.current.value == 'sporchi' then
        menu.close()
        ESX.ShowNotification('Riceverai soldi sporchi')
        MenuDrogaSoldiSporchi()
    end
	end, function(data, menu)
		menu.close()
	end)
end

function MenuDrogaSoldiPuliti()
  local elementi = {
		{icon = 'fas fa-info-circle', label = 'Marijuana', value = 'cimettaprocessata'},
    {icon = 'fas fa-info-circle', label = 'Cocaina', value = 'cocainalavorata'},
    {icon = 'fas fa-info-circle', label = 'Tabacco', value = 'tabaccotrattato'},
	}

  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title    = 'VENDITA DROGA',
		align    = 'top-left',
		elements = elementi
		}, function(data, menu)
      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'drogapuliti', {
        title    = 'Vendi Droga Soldi Puliti',
        elements = OggettiInVendita
    }, function(data2, menu2)
        menu2.close()
        if tonumber(data2.value) then
            TriggerServerEvent('kalash:clodyno:droga:puliti:ritiro', data.current.value, data2.value)
        else
            ESX.ShowNotification('Quantità non valida!')
        end
    end, function(data2, menu2)
        menu2.close()
    end)
	end, function(data, menu)
		menu.close()
	end)
end


function MenuDrogaSoldiSporchi()
  local elementi = {
		{icon = 'fas fa-info-circle', label = 'Marijuana', value = 'cimettaprocessata'},
    {icon = 'fas fa-info-circle', label = 'Cocaina', value = 'cocainalavorata'},
    {icon = 'fas fa-info-circle', label = 'Tabacco', value = 'tabaccotrattato'},
	}

  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title    = 'VENDITA DROGA',
		align    = 'top-left',
		elements = elementi
		}, function(data, menu)
      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'drogaSporchi', {
        title    = 'Vendi Droga Soldi Sporchi',
        elements = OggettiInVendita
    }, function(data2, menu2)
        menu2.close()
        if tonumber(data2.value) then
            TriggerServerEvent('kalash:clodyno:droga:sporchi:ritiro', data.current.value, data2.value)
        else
            ESX.ShowNotification('Quantità non valida!')
        end
    end, function(data2, menu2)
        menu2.close()
    end)
	end, function(data, menu)
		menu.close()
	end)
end

