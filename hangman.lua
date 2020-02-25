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

--This section creates a table with each word in dictionary.txt as an element
file_name = "dictionary.txt"
words = get_lines(file_name) --returns words{table}

--Initalize and play game:
play_game = true
win_count = 0
lose_count = 0
while play_game do
    play_game, game_won = hangman(words)
    if game_won then
        win_count = win_count + 1
    else
        lose_count = lose_count + 1
    end
end

print()
print("Games won:  "..win_count)
print("Games lost: "..lose_count)
print()

if win_count < lose_count then
    print ("You tried... 😂")
elseif win_count == lose_count then
    print("Ehhh")
elseif win_count > lose_count then
    print("You did a great job!")
else
    print("Thanks for playing!")
end


--BONUS TODO:

--Improve the hang guy
--Maybe do GUI, might help decide on the big project?
