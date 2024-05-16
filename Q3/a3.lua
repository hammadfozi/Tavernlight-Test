-- ASSUMPTIONS
-- 1. Didn’t know Lua prior to this, but just quickly searched online to get information. 
--    Applying the basic programming knowledge I have from C++ on to Lua, but might make basic mistakes.
-- 2. There are no indentations added in the code from the question, so adding in indentation to add to the readability of the code.
-- 3. Used the Luanalysis plugin for Jetbrains (Rider) for writing code.

-- BEGIN ANSWER CODE

-- Function to remove Member from Player’s Party
function removeMemberFromParty(playerId, memberName)
    -- Retrieve the player object from the given playerId
    local player = Player(playerId)
    if not player then
        print("Player not found.")
        return
    end
    
    -- Retrieve the player's party
    local party = player:getParty()
    if not party then
        print("Player is not in a party.")
        return
    end

    -- Retrieve the member to be removed as a Player object
    local memberToRemove = Player(memberName)
    if not memberToRemove then
        print("Member to remove not found.")
        return
    end

    -- Iterate through the party members and remove the specified member
    for k, member in pairs(party:getMembers()) do
        if member == memberToRemove then
            party:removeMember(memberToRemove)
            print("Member removed successfully.")
            return
        end
    end

    print("Member not found in the party.")
end

 
-- END ANSWER CODE

-- IMPROVEMENTS MADE
-- Changed function name to show clearly what the function is supposed to do.
-- Added a bit of performance improvement as the player object for the member to be removed is created only once (outside the loop).

-- Added Error Handling to make sure there’s errors printed if the playerid does not belong to a valid player, 
-- if the player’s party is not valid, or memberName of a player is not valid.

-- Added print statements to print out the error reasons if there’s any error that occurs in the function.
-- Added in Indentations for code readability and visibility
-- Added in comments for documentation.

