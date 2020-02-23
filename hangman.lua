--[[
Names: Michael Dahlquist & Kristen Qako
Class: csci324 - spring2020
File: "hangman.lua"
Program Description: This is the game of hangman. Users will guess letters in an
                     attempt to discover all letters of hidden word. Which each
                     failed attempt, a man will gain a limp until he is a fully
                     hanged from the gallow, signifying the end of the game.
                     Repeat guesses will not count against the man's demise.
                     Good luck.
                     --Is this too dramatics lmao
--]]

-- add functions from hangman_functions.lua
dofile("hangman_functions.lua")

--START HANGMAN

print("Hello user, welcome to hangman")

--This section creates a table with every word in dictionary.txt as elements.
file_name = "dictionary.txt"
words = get_lines(file_name) --returns words{table}


play_game = true
won_count = 0
while play_game do
    play_game, game_won = hangman(words)
    if game_won then
        won_count = won_count + 1
    end
end

if won_count < 1 then
    print ("You tried... 😂")
else
    print("You won "..won_count.." games!")
end

--[[
Since we have word length, can't we just make a for loop? Would that be it,
yeah but we are going to need some if's and booleans (probably) to keep track
of what letters have been correctly guessed to reveal them
this is gonna need to be a function i think

Also this is how you block comment

--]]





--TODO:
--Add the hangman game into a function

--BONUS TODO:
--Have game repeat in a while loop so user can keep underplaying
--If this, count how many times won, how many times lost and return at the end
--Improve the hang guy
--Maybe do GUI, might help decide on the big project?
