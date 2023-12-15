local currentXP = 0
local playerLevel =  UnitLevel("player")

local faction = UnitFactionGroup("player")

local isEng = true

local csvDataGerman =  {
    { "Dun Morogh", "Öst. Königreiche", 1, 10, 5.5, "A" },
    { "Durotar", "Kalimdor", 1, 10, 5.5, "H" },
    { "Mulgore", "Kalimdor", 1, 10, 5.5, "H" },
    { "Teldrassil", "Kalimdor", 1, 10, 5.5, "A" },
    { "Tirisfal", "Öst. Königreiche", 1, 10, 5.5, "H" },
    { "Wald von Elwynn", "Öst. Königreiche", 1, 10, 5.5, "A" },
    { "Dunkelküste", "Kalimdor", 10, 20, 15, "A" },
    { "Loch Modan", "Öst. Königreiche", 10, 20, 15, "A" },
    { "Silberwald", "Öst. Königreiche", 10, 20, 15, "A" },
    { "Westfall", "Öst. Königreiche", 10, 20, 15, "A" },
    { "Brachland", "Kalimdor", 10, 25, 17.5, "A/H" },
    { "Rotkammgebirge", "Öst. Königreiche", 15, 25, 20, "A" },
    { "Steinkrallengebirge", "Kalimdor", 15, 27, 21, "H" },
    { "Dämmerwald", "Öst. Königreiche", 18, 30, 24, "A" },
    { "Eschental", "Kalimdor", 18, 30, 24, "A" },
    { "Sumpfland", "Öst. Königreiche", 20, 30, 25, "A" },
    { "Vorgebirge des Hügellands", "Öst. Königreiche", 20, 30, 25, "A" },
    { "Tausend Nadeln", "Kalimdor", 25, 35, 30, "A" },
    { "Alteracgebirge", "Öst. Königreiche", 30, 40, 35, "A" },
    { "Arathihochland", "Öst. Königreiche", 30, 40, 35, "A" },
    { "Desolace", "Kalimdor", 30, 40, 35, "H" },
    { "Schlingendorntal", "Öst. Königreiche", 30, 45, 37.5, "A" },
    { "Marschen von Dustwallow", "Kalimdor", 35, 45, 40, "A" },
    { "Sümpfe des Elends", "Öst. Königreiche", 35, 45, 40, "A" },
    { "Ödland", "Öst. Königreiche", 35, 45, 40, "A" },
    { "Hinterland", "Öst. Königreiche", 40, 50, 45, "A" },
    { "Tanaris", "Kalimdor", 40, 50, 45, "A" },
    { "Feralas", "Kalimdor", 42, 50, 46, "A" },
    { "Sengende Schlucht", "Öst. Königreiche", 45, 50, 47.5, "A" },
    { "Azshara", "Kalimdor", 45, 55, 50, "A" },
    { "Verwüstete Lande", "Öst. Königreiche", 45, 55, 50, "A" },
    { "Teufelswald", "Kalimdor", 48, 55, 51.5, "A" },
    { "Un'Goro-Krater", "Kalimdor", 48, 55, 51.5, "A" },
    { "Brennende Steppe", "Öst. Königreiche", 50, 58, 54, "A" },
    { "Westl. Pestländer", "Öst. Königreiche", 51, 58, 54.5, "A" },
    { "Östl. Pestländer", "Öst. Königreiche", 53, 60, 56.5, "A" },
    { "Winterspring", "Kalimdor", 53, 60, 56.5, "A" },
    { "Gebirgspass der Totenwinde", "Öst. Königreiche", 55, 60, 57.5, "A" },
    { "Moonglade", "Kalimdor", 55, 60, 57.5, "A" },
    { "Silithus", "Kalimdor", 55, 60, 57.5, "A" }
}

local csvDataEnglish = {
    { "Dun Morogh", "Eastern Kingdoms", 1, 10, 5.5, "A" },
    { "Durotar", "Kalimdor", 1, 10, 5.5, "H" },
    { "Mulgore", "Kalimdor", 1, 10, 5.5, "H" },
    { "Teldrassil", "Kalimdor", 1, 10, 5.5, "A" },
    { "Tirisfal Glades", "Eastern Kingdoms", 1, 10, 5.5, "H" },
    { "Elwynn Forest", "Eastern Kingdoms", 1, 10, 5.5, "A" },
    { "Darkshore", "Kalimdor", 10, 20, 15, "A" },
    { "Loch Modan", "Eastern Kingdoms", 10, 20, 15, "A" },
    { "Silverpine Forest", "Eastern Kingdoms", 10, 20, 15, "H" },
    { "Westfall", "Eastern Kingdoms", 10, 20, 15, "A" },
    { "The Barrens", "Kalimdor", 10, 25, 17.5, "A/H" },
    { "Redridge Mountains", "Eastern Kingdoms", 15, 25, 20, "A" },
    { "Stonetalon Mountains", "Kalimdor", 15, 27, 21, "H" },
    { "Duskwood", "Eastern Kingdoms", 18, 30, 24, "A" },
    { "Ashenvale", "Kalimdor", 18, 30, 24, "A" },
    { "Wetlands", "Eastern Kingdoms", 20, 30, 25, "A" },
    { "Hillsbrad Foothills", "Eastern Kingdoms", 20, 30, 25, "A" },
    { "Thousand Needles", "Kalimdor", 25, 35, 30, "A" },
    { "Arathi Highlands", "Eastern Kingdoms", 30, 40, 35, "A" },
    { "Desolace", "Kalimdor", 30, 40, 35, "H" },
    { "Stranglethorn Vale", "Eastern Kingdoms", 30, 45, 37.5, "A" },
    { "Dustwallow Marsh", "Kalimdor", 35, 45, 40, "A" },
    { "Swamp of Sorrows", "Eastern Kingdoms", 35, 45, 40, "A" },
    { "Badlands", "Eastern Kingdoms", 35, 45, 40, "A" },
    { "The Hinterlands", "Eastern Kingdoms", 40, 50, 45, "A" },
    { "Tanaris", "Kalimdor", 40, 50, 45, "A" },
    { "Feralas", "Kalimdor", 42, 50, 46, "A" },
    { "Burning Steppes", "Eastern Kingdoms", 45, 50, 47.5, "A" },
    { "Azshara", "Kalimdor", 45, 55, 50, "A" },
    { "Blasted Lands", "Eastern Kingdoms", 45, 55, 50, "A" },
    { "Felwood", "Kalimdor", 48, 55, 51.5, "A" },
    { "Un'Goro Crater", "Kalimdor", 48, 55, 51.5, "A" },
    { "Western Plaguelands", "Eastern Kingdoms", 50, 58, 54, "A" },
    { "Eastern Plaguelands", "Eastern Kingdoms", 51, 58, 54.5, "A" },
    { "Winterspring", "Kalimdor", 53, 60, 56.5, "A" },
    { "Blasted Lands", "Eastern Kingdoms", 53, 60, 56.5, "A" },
    { "Western Plaguelands", "Eastern Kingdoms", 55, 60, 57.5, "A" },
    { "Moonglade", "Kalimdor", 55, 60, 57.5, "A" },
    { "Silithus", "Kalimdor", 55, 60, 57.5, "A" }
}


local function suitableZones()
    local completeLevelZone = ""
    local csv
    local zoneString
    local ContinentString


    if isEng then
        csv = csvDataEnglish
        zoneString = "Zone: "
        ContinentString = ", Continent: "
    else
        csv = csvDataGerman
        zoneString= "Gebiet: "
        ContinentString = ", Kontinent: "
    end

    for _, line in ipairs(csv) do
        if (faction == "Alliance" and line[6] == "A") or (faction == "Horde" and line[6] == "H") then
            if playerLevel >= line[3] and playerLevel <= line[4] then
                completeLevelZone = "\n" .. zoneString .. tostring(line[1]) .. ContinentString .. tostring(line[2]) .. ", Min: " .. tostring(line[3]) .. ", Max: " .. tostring(line[4]) .. "\n"
                print(completeLevelZone)
            end
        end
    end
end


local function commandReacter(cmd)
    local RED = "|cFFFF0000"
    local END_COLOR = "|r"

    if cmd == "ger" then
        print(RED .. "Zones ist nun deutsch" .. END_COLOR)
        isEng = false
    elseif cmd == "eng" then
        print(RED .. "Zones is now in English" .. END_COLOR)
        isEng = true
    elseif cmd == "" then
        suitableZones()
    end
end

-- Slash command handler registration
SLASH_ZONE1 = "/zones"
SlashCmdList["ZONE"] = commandReacter

print("Zones is running! Type /zones to see all suitable leveling zones. \nToggle between German and English using /zones ger and /zones eng.")
