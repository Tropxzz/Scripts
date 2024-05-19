local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local version = "1.0.0"

function priant(content) print(tostring(content)) end

function getrole()
    local admins = {} 
    local BETA = {} 
    local owner = 3686372594
    local userId = game.Players.LocalPlayer.UserId

    for _, v in pairs(admins) do
        if userId == v then
            return "Admin"
        end
    end

    for _, v in pairs(BETA) do
        if userId == v then
            return "BETA"
        end
    end

    if userId == owner then
        return "Owner"
    end

    return "User"
end




local Window = Fluent:CreateWindow({
    Title = "Api Library (Api Abuser) " .. version.." ".." | "..getrole().." | ",
    SubTitle = "by Tropxz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Insert -- Used when theres no MinimizeKeybind
})

if not isfolder("TropsScripts") then
    makefolder("TropsScripts")
end

if not isfolder("TropsScripts/ApiAbuser") then
    makefolder("TropsScripts/ApiAbuser")
end

if not isfile("TropsScripts/ApiAbuser/Theme.txt") then
    writefile("TropsScripts/ApiAbuser/Theme.txt", "Darker")
end

if isfolder("TropsScripts") and isfolder("TropsScripts/ApiAbuser") and isfile("TropsScripts/ApiAbuser/Theme.txt") then
    if readfile("TropsScripts/ApiAbuser/Theme.txt") == "" then
        Fluent:SetTheme("Dark")
    else
        Fluent:SetTheme(tostring(readfile("TropsScripts/ApiAbuser/Theme.txt")))
    end
end

local Tabs = {
    Acknowledgements = Window:AddTab({ Title = "Acknowledgements", Icon = "book"}),
    Api = Window:AddTab({ Title = "Apis", Icon = "library"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Window:SelectTab(1)

Tabs.Acknowledgements:AddParagraph({
    Title = "Acknowledgements",
    Content = "Hello "..game.Players.LocalPlayer.DisplayName.." \n My script Api library has some aknowledge ments so here we go \n Animal Facts - https://animality.xyz/ \n Dark Joke - https://v2.jokeapi.dev/ \n Kayne api - https://api.kanye.rest/ \n Dictionary Api - https://dictionaryapi.dev/ \n Shorten url -  https://cleanuri.com/ \n Lyrics API - lyrics.ovh \n Gender Name thing api - https://genderize.io \n the httprequest code - Chatgpt (i forgot how to do httpget and httppost dont blame me :( \n thank you very much for using api library by Tropxz/Jimmy (were the same people if you couldnt tell.)"
})

local animalf = Tabs.Api:AddDropdown("Dropdown", {
    Title = "Animal Facts",
    Values = {"bird", "cat", "dog", "panda", "redpanda", "koala", "fox", "whale", "dolphin", "kangaroo", "rabbit", "lion", "bear", "duck"},
    Description = "Select a animal for a fact. 🐕",
    Multi = false,
    Default = "Select one",
})

animalf:OnChanged(function(Value)
    local link = "https://api.animality.xyz/all/"..Value
    local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    
    if not http_request then
        print("HTTP request function not found")
        return
    end
    
    local response = http_request({
        Url = link,
        Method = "GET"
    })
    
    if response.StatusCode == 200 then
        local body = response.Body
        local data = game:GetService("HttpService"):JSONDecode(body)
        if data and data.fact then
            Fluent:Notify({
                Title = Value.." Fact",
                Content = data.fact,
                Duration = 5 -- Set to nil to make the notification not disappear
            })
        else
            print("Failed to retrieve Joke")
        end
    else
        print("HTTP request failed with status code:", response.StatusCode)
    end
end)


Tabs.Api:AddButton({
    Title = "Dark Joke",
    Description = "Get a dark joke from v2.jokeapi.dev (sv433.net/jokeapi/v2)",
    Callback = function()
        local link = "https://v2.jokeapi.dev/joke/Any?type=single"
        local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if not http_request then
            print("HTTP request function not found")
            return
        end
        
        local response = http_request({
            Url = link,
            Method = "GET"
        })
        
        if response.StatusCode == 200 then
            local body = response.Body
            local data = game:GetService("HttpService"):JSONDecode(body)
            if data and data.joke then
                Fluent:Notify({
                    Title = "Joke",
                    Content = data.joke,
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                print("Failed to retrieve Joke")
            end
        else
            print("HTTP request failed with status code:", response.StatusCode)
        end
    end
})


Tabs.Api:AddButton({
    Title = "Kanye Quote",
    Description = "🧔🏿",
    Callback = function()
        local link = "https://api.kanye.rest/"
        local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if not http_request then
            print("HTTP request function not found")
            return
        end
        
        local response = http_request({
            Url = link,
            Method = "GET"
        })
        
        if response.StatusCode == 200 then
            local body = response.Body
            local data = game:GetService("HttpService"):JSONDecode(body)
            if data and data.quote then
                Fluent:Notify({
                    Title = "kanye quote",
                    Content = data.quote,
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                print("Failed to retrieve quote")
            end
        else
            priant("HTTP request failed with status code:", response.StatusCode)
        end
    end
})  


local Input = Tabs.Api:AddInput("Word", {
    Title = "Dictionary",
    Default = "",
    Description = "Enter a word.",
    Placeholder = "Word",
    Numeric = false, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(value)
        print(value)
        local link = "https://api.dictionaryapi.dev/api/v2/entries/en/" .. value
        local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if not http_request then
            print("HTTP request function not found")
            return
        end
        
        local response = http_request({
            Url = link,
            Method = "GET"
        })
        
        if response.StatusCode == 200 then
            local body = response.Body
            local data = game:GetService("HttpService"):JSONDecode(body)
            
            if data and data[1] and data[1].meanings then
                -- Collect definitions from all parts of speech
                local definitions = {}
                for _, meaning in ipairs(data[1].meanings) do
                    for _, definition in ipairs(meaning.definitions) do
                        table.insert(definitions, definition.definition)
                    end
                end
                
                -- Combine definitions into a single string for notification
                local combined_definitions = table.concat(definitions, "\n")
                
                Fluent:Notify({
                    Title = "Definition of " .. value,
                    Content = combined_definitions,
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                print("Failed to retrieve definitions")
            end
        else
            print("HTTP request failed with status code:", response.StatusCode)
        end
    end
})

local aInput = Tabs.Api:AddInput("Link", {
    Title = "Link",
    Default = "",
    Description = "Enter a Link.",
    Placeholder = "Link",
    Numeric = false, -- Allows any characters
    Finished = true, -- Only calls callback when you press enter
    Callback = function(value)
        print("Original URL: " .. value)
        local link = "https://cleanuri.com/api/v1/shorten"
        local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

        if not http_request then
            print("HTTP request function not found")
            return
        end
        
        local response = http_request({
            Url = link,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = "url=" .. value
        })

        if response.StatusCode == 200 then
            local body = response.Body
            local data = game:GetService("HttpService"):JSONDecode(body)
            if data and data.result_url then
                
                if setclipboard then
                    setclipboard(data.result_url)
                end
                if toclipboard then
                    toclipboard(data.result_url)
                end

                Fluent:Notify({
                    Title = "Copied the shortened link.",
                    Content = data.result_url,
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                print("Failed to retrieve shortened URL")
            end
        else
            print("HTTP request failed with status code:", response.StatusCode)
        end
    end
})

Tabs.Api:AddParagraph({
    Title = "Get Lyrics",
    Content = "Lyric Getter"
})

local Auth = nil
local song = nil
        
local Author = Tabs.Api:AddInput("Author", {
    Title = "Author",
    Default = "",
    Description = "Enter the song artist e.g. Eminem, The weekend, etc (instead of spaces do %20)",
    Placeholder = "Author",
    Numeric = false, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value
        Auth = Value

    end
})

local Song = Tabs.Api:AddInput("Song", {
    Title = "Song",
    Default = "",
    Description = "Enter the song Name e.g. Lose yourself, Starboy (instead of spaces do %20)",
    Placeholder = "Song name",
    Numeric = false, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
        song = Value
    end
})

Tabs.Api:AddButton({
    Title = "Submit",
    Description = "See if your song is registered and get your song lyrics.",
    Callback = function()
        local link = "https://api.lyrics.ovh/v1/"..Auth.."/"..song
        local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if not http_request then
            print("HTTP request function not found")
            return
        end
        
        local response = http_request({
            Url = link,
            Method = "GET"
        })
        
        if response.StatusCode == 200 then
            local body = response.Body
            local data = game:GetService("HttpService"):JSONDecode(body)
            if data and data.lyrics then
                Fluent:Notify({
                    Title = "lyrics",
                    Content = data.lyrics,
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                print("Failed to retrieve quote")
            end
        else
            priant("HTTP request failed with status code:", response.StatusCode)
        end
    end
})



Tabs.Api:AddParagraph({
    Title = "Scroll",
    Content = "Scroll for more apis 🔽"
})

local MaleOrFemale = Tabs.Api:AddInput("MOF", {
    Title = "Male or female?",
    Default = "",
    Description = "Enter in a name for a result.",
    Placeholder = "Name",
    Numeric = false, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        link = "https://api.genderize.io/?name="..Value
        local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if not http_request then
            print("HTTP request function not found")
            return
        end
        
        local response = http_request({
            Url = link,
            Method = "GET"
        })
        
        if response.StatusCode == 200 then
            local body = response.Body
            local data = game:GetService("HttpService"):JSONDecode(body)
            if data and data.gender and data.probability then
                Fluent:Notify({
                    Title = "Is ___ a male or a female?",
                    Content = Value.." Is a "..data.gender.." By the probability of "..data.probability,
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                print("Failed to retrieve it")
            end
        else
            priant("HTTP request failed with status code:", response.StatusCode)
        end
    end
})


-- settings

local asdasdasdsadasdasdasdasdasd = Tabs.Settings:AddDropdown("Dropdown", {
    Title = "Choose your theme",
    Values = {"Dark","Darker","Light","Aqua", "Amethyst", "Rose"},
    Multi = false,
    Default = "Choose one",
})
asdasdasdsadasdasdasdasdasd:OnChanged(function(Value)
    if not justloaded then
        Fluent:SetTheme(Value)
        delfile("TropsScripts/ApiAbuser/Theme.txt")
        writefile("TropsScripts/ApiAbuser/Theme.txt", tostring(Value))
    end
end)


print("Ran with no errors")
