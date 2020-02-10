--[[
Names: Michael Dahlquist & Kristen Qako
Class: csci324 - spring2020
File: "hangman.lua"
Program Description: This is the game of hangman.
--]]

-- add functions from hangman_functions.lua
dofile("hangman_functions.lua")

--START HANGMAN
print("Hello user, welcome to hangman")

--This section creates a table with every word in dictionary.txt as elements.
words, words_length = getwords("dictionary.txt")
--[[]
words[1] = "apple"
words[2] = "banana"
words[3] = "cactus"
words[4] = "dog"
words[5] = "empty"
words[6] = "food"
words[7] = "google"
words[8] = "hello"
words[9] = "indigo"
words[10] = "jumping"
]]--

--This shows the user the size of the table
print(words_length.." words in table")

--This section finds a random index of the table, meaning the word is randomly picked.
math.randomseed(os.time()) --need to run first
random_index = math.random(1,words_length)

--prints random index and the word
print("Randomly picked "..random_index)
--print(words[random_index])

--calculates and prints the word_length
word_length = string.len( words[random_index] )
print("Word size is "..word_length)

--[[
Since we have word length, can't we just make a for loop? Would that be it,
yeah but we are going to need some if's and booleans (probably) to keep track
of what letters have been correctly guessed to reveal them
this is gonna need to be a function i think

Also this is how you block comment

--]]

--This initializes each letter of the word to false as a way to test if the user inputs a correct letter later in the code.
show_letter = {} --better name for this variable??
for i = 1, word_length do --this initalized them to false
    show_letter[i] = false
end

--Empty table that will store the users guesses.
letters_guessed = {}

wrong_ct = 0 --number of times user guessed wrong
correct_ct = 0--number of times user guessed correctly
word = words[random_index]

--This function prints out the players incorrect letter guesses. It is in order of appearance.
function print_wrong(letters_guessed, wrong_ct)
    print("Guessed incorrect letters:")
    for i = 0, wrong_ct-1 do
        io.write(letters_guessed[i].." ")
    end
end

--I made the line printing a function that calls gallow with the attempt
--We could probably make a game function and just have the game in a loop

--This function is what runs the game.
while (wrong_ct < 6) and (correct_ct < string.len(word)) do --this while loop     runs until wrong_ct exceeds 6 or the user gets the word.
    gallow(wrong_ct)
    io.write("Your word is:\n")
    for i = 1, string.len(word) do --prints underscore for hidden letters and
        if show_letter[i] then     --prints the letters if guessed correctly
            io.write(string.sub(word,i,i).." ")--we would print the ith character
        else
            io.write("_ ")
        end
    end
    print()
    print_wrong(letters_guessed, wrong_ct)
    print()

  --This section of code takes users guesses and checks whether a wrong input has been guessed before.
  --We decided that letters that have been shown should not display that output and we just continue to show the current game.
    io.write("Please guess a letter: ")
    ch = io.read(2); --reads the input
    ch = string.upper(string.sub(ch,1,1) )
    char_found = false;
    char_unique = false;
    while not char_unique do
        char_unique = true
        for k = 0, wrong_ct do
            if letters_guessed[k] == ch then --checks if letter has been guessed
                io.write("You already guessed that, input a new letter:")
                ch = io.read(2);
                ch = string.upper( string.sub(ch,1,1) )
                char_unique = false
            end
        end
    end
 --This section of code checks whether the user input is correct. If it is correct, we make that index of the word true, then increment the number of correctly counted words.
    for i = 1, string.len(word) do
        if string.upper(string.sub(word,i,i)) == ch then --compares letter in word to the users guess
            if show_letter[i] then
                char_found = true
            else
                char_found = true
                show_letter[i] = true;
                correct_ct = correct_ct + 1
            end
        end
    end

    if not char_found then
        letters_guessed[wrong_ct] = ch
        wrong_ct = wrong_ct + 1
    end
    print() -- (word, word_guessed, attempt)
end

gallow(wrong_ct)
io.write("Your word is:\n")
for i = 1, string.len(word) do
    if show_letter[i] or wrong_ct == 6 then
        io.write(string.sub(word,i,i).." ")--here we would print the ith character
    else
        io.write("_ ")
    end
end
print()
print_wrong(letters_guessed, wrong_ct)
print()
print()
if wrong_ct < 6 then print("Congratulations, you guessed the word!")
else print("Sorry, you lost! The word was: ", word)
end
print()

--TODO:
-- import dictionary file into table (after we make sure it works on 10 words)
