local cfg = {}

--The model and animation (or in other word the dict) for the blackmarket npc. 
cfg.blackMarketPed = {
    {model = "u_m_m_jewelsec_01", anim = "WORLD_HUMAN_SMOKING"}
}

--The model and animation (or in other word the dict) for the informer npc
cfg.informerPed = {
    InformerPed = {model = "g_m_y_pologoon_02", anim = "WORLD_HUMAN_SMOKING"}
}

--What jobs should force the informer and the blackmarket to change location and the range the needed for it to happen.
cfg.blackistedJobs = {
    --The range for how close the jobs listed below should be before the informer and the blackmarket will be forced to change location.
    Range = 15,
    --What jobs should force the informer and the blackmarket to change location
    Jobs = {
        {name = ''}
    }
}

--True = show the blip for the informer on the map, False = don't show the blip for the informer on the map
cfg.useInformerBlip = true
--True = show the blip for the blackmarket on the map without having to talk with the informer, False = only show the blip on the map when the player has talked with the informer
cfg.useMarketBlip = true

--How close the user needs to go before the menu opens, used in the range check in the client file
cfg.npcRange = 2

--The locations where the blackmarket npc can spawn
cfg.marketPedSpawnLocations = {
    [1] = {['x'] = 55.56, ['y'] = 165.78, ['z'] = 104.79, ['h'] = 240.58}
}

--The locations where the informer npc can spawn
cfg.informerPedSpawnLocations = {
    [1] = {['x'] = -1808.01, ['y'] = -404.5, ['z'] = 44.61, ['h'] = 279.01}
}

return cfg