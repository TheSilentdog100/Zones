local currentXP = 0
local playerLevel = UnitLevel("player")

local faction = UnitFactionGroup("player")

local isEng = true

local csvDataGerman = {
    { "Dun Morogh",           "Östliche Königreiche", 1,  10, 5.5,  "A" },
    { "Durotar",              "Kalimdor",             1,  10, 5.5,  "H" },
    { "Mulgore",              "Kalimdor",             1,  10, 5.5,  "H" },
    { "Teldrassil",           "Kalimdor",             1,  10, 5.5,  "A" },
    { "Tirisfal",             "Östliche Königreiche", 1,  10, 5.5,  "H" },
    { "Wald von Elwynn",      "Östliche Königreiche", 1,  10, 5.5,  "A" },
    { "Dunkelküste",          "Kalimdor",             10, 20, 15,   "A" },
    { "Loch Modan",           "Östliche Königreiche", 10, 20, 15,   "A" },
    { "Silberwald",           "Östliche Königreiche", 10, 20, 15,   "H" },
    { "Westfall",             "Östliche Königreiche", 10, 20, 15,   "A" },
    { "Brachland",            "Kalimdor",             10, 25, 17.5, "A/H" },
    { "Rotkammgebirge",       "Östliche Königreiche", 15, 25, 20,   "A" },
    { "Steinkrallengebirge",  "Kalimdor",             15, 27, 21,   "H" },
    { "Dämmerwald",           "Östliche Königreiche", 18, 30, 24,   "A" },
    { "Eschental",            "Kalimdor",             18, 30, 24,   "A/H" },
    { "Sumpfland",            "Östliche Königreiche", 20, 30, 25,   "A" },
    { "Vorgebirge des Hügellands", "Östliche Königreiche", 20, 30, 25, "H" },
    { "Tausend Nadeln",       "Kalimdor",             25, 35, 30,   "A/H" },
    { "Arathihochland",       "Östliche Königreiche", 30, 40, 35,   "A/H" },
    { "Desolace",             "Kalimdor",             30, 40, 35,   "A/H" },
    { "Schlingendorntal",     "Östliche Königreiche", 30, 45, 37.5, "A/H" },
    { "Düstermarschen",       "Kalimdor",             35, 45, 40,   "A/H" },
    { "Sümpfe des Elends",    "Östliche Königreiche", 35, 45, 40,   "A/H" },
    { "Ödland",               "Östliche Königreiche", 35, 45, 40,   "A/H" },
    { "Hinterland",           "Östliche Königreiche", 40, 50, 45,   "A/H" },
    { "Tanaris",              "Kalimdor",             40, 50, 45,   "A/H" },
    { "Feralas",              "Kalimdor",             42, 50, 46,   "A/H" },
    { "Brennende Steppe",     "Östliche Königreiche", 45, 50, 47.5, "A/H" },
    { "Azshara",              "Kalimdor",             45, 55, 50,   "H" },
    { "Verwüstete Lande",     "Östliche Königreiche", 45, 55, 50,   "A/H" },
    { "Teufelswald",          "Kalimdor",             48, 55, 51.5, "A/H" },
    { "Krater von Un'Goro",   "Kalimdor",             48, 55, 51.5, "A/H" },
    { "Westliche Pestländer", "Östliche Königreiche", 50, 58, 54,   "A/H" },
    { "Östliche Pestländer",  "Östliche Königreiche", 51, 58, 54.5, "A/H" },
    { "Winterspring",         "Kalimdor",             53, 60, 56.5, "A/H" },
    { "Verwüstete Lande",     "Östliche Königreiche", 53, 60, 56.5, "A/H" },
    { "Mondlichtung",         "Kalimdor",             55, 60, 57.5, "A/H" },
    { "Silithus",             "Kalimdor",             55, 60, 57.5, "A/H" }
}


local csvDataEnglish = {
    { "Dun Morogh",           "Eastern Kingdoms", 1,  10, 5.5,  "A" },
    { "Durotar",              "Kalimdor",         1,  10, 5.5,  "H" },
    { "Mulgore",              "Kalimdor",         1,  10, 5.5,  "H" },
    { "Teldrassil",           "Kalimdor",         1,  10, 5.5,  "A" },
    { "Tirisfal Glades",      "Eastern Kingdoms", 1,  10, 5.5,  "H" },
    { "Elwynn Forest",        "Eastern Kingdoms", 1,  10, 5.5,  "A" },
    { "Darkshore",            "Kalimdor",         10, 20, 15,   "A" },
    { "Loch Modan",           "Eastern Kingdoms", 10, 20, 15,   "A" },
    { "Silverpine Forest",    "Eastern Kingdoms", 10, 20, 15,   "H" },
    { "Westfall",             "Eastern Kingdoms", 10, 20, 15,   "A" },
    { "The Barrens",          "Kalimdor",         10, 25, 17.5, "A/H" },
    { "Redridge Mountains",   "Eastern Kingdoms", 15, 25, 20,   "A" },
    { "Stonetalon Mountains", "Kalimdor",         15, 27, 21,   "H" },
    { "Duskwood",             "Eastern Kingdoms", 18, 30, 24,   "A" },
    { "Ashenvale",            "Kalimdor",         18, 30, 24,   "A/H" },
    { "Wetlands",             "Eastern Kingdoms", 20, 30, 25,   "A" },
    { "Hillsbrad Foothills",  "Eastern Kingdoms", 20, 30, 25,   "H" },
    { "Thousand Needles",     "Kalimdor",         25, 35, 30,   "A/H" },
    { "Arathi Highlands",     "Eastern Kingdoms", 30, 40, 35,   "A/H" },
    { "Desolace",             "Kalimdor",         30, 40, 35,   "A/H" },
    { "Stranglethorn Vale",   "Eastern Kingdoms", 30, 45, 37.5, "A/H" },
    { "Dustwallow Marsh",     "Kalimdor",         35, 45, 40,   "A/H" },
    { "Swamp of Sorrows",     "Eastern Kingdoms", 35, 45, 40,   "A/H" },
    { "Badlands",             "Eastern Kingdoms", 35, 45, 40,   "A/H" },
    { "The Hinterlands",      "Eastern Kingdoms", 40, 50, 45,   "A/H" },
    { "Tanaris",              "Kalimdor",         40, 50, 45,   "A/H" },
    { "Feralas",              "Kalimdor",         42, 50, 46,   "A/H" },
    { "Burning Steppes",      "Eastern Kingdoms", 45, 50, 47.5, "A/H" },
    { "Azshara",              "Kalimdor",         45, 55, 50,   "H" },
    { "Blasted Lands",        "Eastern Kingdoms", 45, 55, 50,   "A/H" },
    { "Felwood",              "Kalimdor",         48, 55, 51.5, "A/H" },
    { "Un'Goro Crater",       "Kalimdor",         48, 55, 51.5, "A/H" },
    { "Western Plaguelands",  "Eastern Kingdoms", 50, 58, 54,   "A/H" },
    { "Eastern Plaguelands",  "Eastern Kingdoms", 51, 58, 54.5, "A/H" },
    { "Winterspring",         "Kalimdor",         53, 60, 56.5, "A/H" },
    { "Blasted Lands",        "Eastern Kingdoms", 53, 60, 56.5, "A/H" },
    { "Moonglade",            "Kalimdor",         55, 60, 57.5, "A/H" },
    { "Silithus",             "Kalimdor",         55, 60, 57.5, "A/H" }
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
        zoneString = "Gebiet: "
        ContinentString = ", Kontinent: "
    end

    for _, line in ipairs(csv) do
        if (faction == "Alliance" and (line[6] == "A" or line[6] == "A/H")) or
            (faction == "Horde" and (line[6] == "H" or line[6] == "A/H")) then
            if playerLevel >= line[3] and playerLevel <= line[4] then
                completeLevelZone = "\n" ..
                zoneString ..
                tostring(line[1]) ..
                ContinentString ..
                tostring(line[2]) .. ", Min: " .. tostring(line[3]) .. ", Max: " .. tostring(line[4]) .. "\n"
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

print(
"Zones is running! Type /zones to see all suitable leveling zones. \nToggle between German and English using /zones ger and /zones eng.")
