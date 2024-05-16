-- ASSUMPTIONS
-- 1. Didn’t know Lua prior to this, but just quickly searched online to get information. 
--    Applying the basic programming knowledge I have from C++ on to Lua, but might make basic mistakes.
-- 2. There are no indentations added in the code from the question, so adding in indentation to add to the readability of the code.
-- 3. Used the Luanalysis plugin for Jetbrains (Rider) for writing code.

-- BEGIN ANSWER CODE

-- This method prints names of all guilds that have less than memberCount max members
function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local structuredQuery = string.format(selectGuildQuery, memberCount)
    
    -- Execute the query and store the result
    local resultId = db.storeQuery(structuredQuery)
    if resultId == false then
        print("Failed to execute query or no results found.")
        return
    end
    
    -- Iterate over all rows in the result set
    repeat
        local guildName = db.getResultData(resultId, "name")
        if not guildName then
            print("Error retrieving guild name from the database.")
        else
            print(guildName)
        end
    until not db.next(resultId)

    -- Free the result set
    db.free(resultId)
end
 
-- END ANSWER CODE

-- IMPROVEMENTS MADE
-- Added Error Handling to make sure there’s errors printed if the guildName is invalid. 
-- Also handled the error case of resultId being false. Lastly the db.getResultData might return nil

-- Used repeat to loop over the result set rows (the original question was just printing the first name, while the function 
-- comment states that it should return all the guild names with the condition)

-- Freeing the db connection after usage to ensure cleanup
-- Added in Indentations for code readability and visibility
-- Added in comments for documentation.
