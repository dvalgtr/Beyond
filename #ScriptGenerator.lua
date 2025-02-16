gg.alert("Created By : DaveCx / SWTeam")
local Region = {
    "Anonymous",
    "C Alloc",
    "Code App",
    "C Data",
    "Other"
}
local regionList = {
    ["Anonymous"] = "gg.REGION_ANONYMOUS",
    ["C Alloc"] = "gg.REGION_C_ALLOC",
    ["Code App"] = "gg.REGION_CODE_APP",
    ["C Data"] = "gg.REGION_C_DATA",
    ["Other"] = "gg.REGION_OTHER"
}
local stringSelect = gg.multiChoice(Region, nil, "Select Region (Recommended : Anonymous)")
local String = ""
if stringSelect then
    for key, _ in pairs(stringSelect) do
        if String == "" then
            String = regionList[Region[key]]
        else
            String = String .. " | " .. regionList[Region[key]]
        end
    end
end
if String == "" then
    String = "gg.REGION_ANONYMOUS"
end
local input_FN
while true do
    local input = gg.prompt({"Insert File Name (without .lua):"}, {"Generate"}, {"text"})
    if input and input[1] ~= "" then 
        input_FN = input[1] .. ".lua" 
        break 
    else 
        gg.alert("Lua Name cannot be empty!") 
    end
end
local main_Func
while true do
    local input = gg.prompt({"Insert Main Function Name:"}, {"Menu"}, {"text"})
    if input and input[1] ~= "" then
        main_Func = input[1]
        break
    else
        gg.alert("Main Function name cannot be empty!")
    end
end
local menuChoice = gg.choice({"Single Choice (gg.choice)", "Multi Choice (gg.multiChoice)"}, nil, "Choose Menu Type:")
if not menuChoice then gg.alert("DaveCx - SWTeam") os.exit() end
local func_Count
while true do
    local input = gg.prompt({"Insert number of functions (1-1000):"}, {0}, {"number"})
    if input and tonumber(input[1]) then
        func_Count = tonumber(input[1])
        if func_Count >= 1 and func_Count <= 1000 then 
            break 
        else 
            gg.alert("Please enter a number between 1 and 1000!") 
        end
    else 
        gg.alert("Invalid input, please try again!") 
    end
end
local filePath = "/storage/emulated/0/" .. input_FN
local davecx = "-- Created By DaveCx / SWTeam\n\n"
davecx = davecx .. "gg.setRanges(" .. String .. ")\n\n"
for i = 1, func_Count do
    davecx = davecx .. "function Function" .. i .. "()\n"
    davecx = davecx .. "-- Created By DaveCx / SWTeam\n"
    davecx = davecx .. "end\n\n"
end
davecx = davecx .. "function " .. main_Func .. "()\n"
if menuChoice == 1 then
    davecx = davecx .. [[
    local choice = gg.choice({
]]
    for i = 1, func_Count do
        davecx = davecx .. '        "Function ' .. i .. '",\n'
    end
    davecx = davecx .. '        "Exit"\n    }, nil, "Credit : DaveCx - SWTeam")\n\n'
    davecx = davecx .. '    if not choice then return end\n\n'
    for i = 1, func_Count do
        davecx = davecx .. '    if choice == ' .. i .. ' then\n        Function' .. i .. '()\n    end\n\n'
    end
    davecx = davecx .. '    if choice == ' .. (func_Count + 1) .. ' then\n        os.exit()\n    end\n'
elseif menuChoice == 2 then
    davecx = davecx .. [[
    local choice = gg.multiChoice({
]]
    for i = 1, func_Count do
        davecx = davecx .. '        "Function ' .. i .. '",\n'
    end
    davecx = davecx .. '        "Exit"\n    }, {}, "Credit : DaveCx - SWTeam")\n\n'
    davecx = davecx .. '    if not choice then return end\n\n'
    for i = 1, func_Count do
        davecx = davecx .. '    if choice[' .. i .. '] then\n        Function' .. i .. '()\n    end\n\n'
    end
    davecx = davecx .. '    if choice[' .. (func_Count + 1) .. '] then\n        os.exit()\n    end\n'
end
davecx = davecx .. "end\n\n"
davecx = davecx .. [[
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        ]] .. main_Func .. [[()
    end
end
]]
local file = io.open(filePath, "w")
if file then
    file:write(davecx)
    file:close()
    gg.alert("Script saved at : " .. filePath)
else
    gg.alert("Failed to Save!")
end