-- ASSUMPTIONS
-- 1. Didn’t know Lua prior to this, but just quickly searched online to get information. 
--    Applying the basic programming knowledge I have from C++ on to Lua, but might make basic mistakes.
-- 2. There are no indentations added in the code from the question, so adding in indentation to add to the readability of the code.
-- 3. Used the Luanalysis plugin for Jetbrains (Rider) for writing code.

-- BEGIN ANSWER CODE

-- Added constants to allow for modularity and parameterization easily.
local STORAGE_KEY = 1000
local STORAGE_RESET_VALUE = -1
local EVENT_DELAY = 1000  -- Delay in milliseconds

-- Function to reset the storage value for a player
local function releaseStorage(player)
    if not player or type(player.setStorageValue) ~= "function" then
        print("Error: Invalid player object or missing player.setStorageValue function")
        return
    end
    -- Set the storage value to STORAGE_RESET_VALUE to show reset/release
    player:setStorageValue(STORAGE_KEY, STORAGE_RESET_VALUE)
end

-- Function to handle player logic for the logout event
function onLogout(player)
    if not player or type(player.getStorageValue) ~= "function" then
        print("Error: Invalid player object or missing player.getStorageValue function")
        return false  -- Indicate failure in handling the logout
    end
    
    -- Check if the specific storage value is set to 1
    if player:getStorageValue(STORAGE_KEY) == 1 then
        -- Schedule the releaseStorage function after a delay
        -- Ensures that any other post-logout logic can complete successfully
       addEvent(releaseStorage, EVENT_DELAY, player)
    end
    -- Return true to indicate successful handling of the logout
    return true
end

-- END ANSWER CODE

-- IMPROVEMENTS MADE
-- Added Error Handling to make sure the player object is valid and the required functions are available before they are called.
-- Added Constants to make it easier for us to configure the code parameters.
-- Added in Indentations for code readability and visibility
-- Added in comments for documentation.
