ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('kalash:clodyno:pulizia:ritiro')
AddEventHandler('kalash:clodyno:pulizia:ritiro', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
      local itemCount = xPlayer.getInventoryItem('black_money').count
      if itemCount >= 99999 then
          xPlayer.removeInventoryItem('black_money', 100000)
          xPlayer.addInventoryItem('money', 70000)
          xPlayer.showNotification('Hai pulito 100K')
      else
          xPlayer.showNotification('Non hai abbastanza soldi sporchi')
      end
  end
end)
		
local OggettiInVenditaPuliti = {
  ['cimettaprocessata'] = {price = 1, label = 'Marijuana'},
  ['cocainalavorata'] = {price = 1, label = 'Cocaina'},
  ['tabaccotrattato'] = {price = 1, label = 'Tabacco'},
}

RegisterServerEvent('kalash:clodyno:droga:puliti:ritiro', function(item, amount)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  amount = tonumber(amount)
  if xPlayer then
      if OggettiInVenditaPuliti[item] then
          if xPlayer.getInventoryItem(item).count >= amount then
              xPlayer.removeInventoryItem(item, amount)
              xPlayer.addAccountMoney('money', OggettiInVenditaPuliti[item].price * amount)
              xPlayer.showNotification('Hai venduto x'.. amount ..' di '.. OggettiInVenditaPuliti[item].label ..' per '.. OggettiInVenditaPuliti[item].price * amount ..'$')
          else
              xPlayer.showNotification('Non hai abbastanza oggetti!')
          end
      end
  end
end)

local OggettiInVenditaSporchi = {
  ['cimettaprocessata'] = {price = 1, label = 'Marijuana'},
  ['cocainalavorata'] = {price = 1, label = 'Cocaina'},
  ['tabaccotrattato'] = {price = 1, label = 'Tabacco'},
}

RegisterServerEvent('kalash:clodyno:droga:sporchi:ritiro', function(item, amount)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  amount = tonumber(amount)
  if xPlayer then
      if OggettiInVenditaSporchi[item] then
          if xPlayer.getInventoryItem(item).count >= amount then
              xPlayer.removeInventoryItem(item, amount)
              xPlayer.addAccountMoney('black_money', OggettiInVenditaSporchi[item].price * amount)
              xPlayer.showNotification('Hai venduto x'.. amount ..' di '.. OggettiInVenditaSporchi[item].label ..' per '.. OggettiInVenditaSporchi[item].price * amount ..'$')
          else
              xPlayer.showNotification('Non hai abbastanza oggetti!')
          end
      end
  end
end)