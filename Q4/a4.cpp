/* ASSUMPTIONS
1. Didn’t know Lua prior to this, but just quickly searched online to get information.
   Applying the basic programming knowledge I have from C++ on to Lua, but might make basic mistakes.
2. There are no indentations added in the code from the question, so adding in indentation to add to the readability of the code.
3. Used the Luanalysis plugin for Jetbrains (Rider) for writing code. */

// BEGIN ANSWER CODE

#include <iostream>  // Include for std::cout
#include <memory>    // Include for std::unique_ptr
#include <string>    // Include for string

#include "Game.h"
#include "IOLoginData.h"

// Function to add an item to a player
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* rawPlayer = g_game.getPlayerByName(recipient);

    // Using a Unique Pointer as we only need this pointer only to point to the Player Object and when this pointer goes
    // out of scope, it should automatically destroy the Player Object
    std::unique_ptr<Player> playerManager;
    if (!rawPlayer)
    {
        playerManager.reset(new Player(nullptr));  // Automatically deletes the old Player
        if (!IOLoginData::loadPlayerByName(playerManager.get(), recipient))
        {
            std::cout << "Error: Failed to load player data for '" << recipient << "'.\n";
            return;  // Automatically deallocates memory upon return
        }
        rawPlayer = playerManager.get();  // Use raw pointer for operations below
        std::cout << "Created and loaded new player for '" << recipient 
        << "' successfully.\n";
    }
    Item* item = Item::CreateItem(itemId);
    if (!item)
    {
        std::cout << "Error: Failed to create item with ID " << itemId << ".\n";
        return;
    }

    if (!g_game.internalAddItem(rawPlayer->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT))
    {
        std::cout << "Error: Failed to add item to player's inbox.\n";
        return;  // Ensures item is not left dangling if not added
    }
    
    if (rawPlayer->isOffline())
    {
        if (!IOLoginData::savePlayer(rawPlayer))
        {
            std::cout << "Warning: Failed to save player data for offline player '"
            << recipient << "'.\n";
        }
        else
            std::cout << "Offline player data saved for '" << recipient << "'.\n";
    }
    
    std::cout << "Item successfully added to player's inbox.\n";
    // No need to manually delete Player; unique_ptr will automatically deallocate memory when it goes out of scope
}

// END ANSWER CODE

/* IMPROVEMENTS MADE

1. Added a smart pointer (Unique Pointer) to manage the lifecycle of player objects which are created dynamically.
This helps us with freeing the memory automatically when the object goes out of scope.

2. Additionally use a raw pointer to perform operations on the player object. 
3. Added Error Handling to make sure that item is valid, Player is valid, etc.
4. Added print statements to print out the error reasons if there’s any error that occurs in the function.
5. Added in Indentations for code readability and visibility
6. Added in comments for documentation.*/
