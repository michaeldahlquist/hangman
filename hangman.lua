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

--This section creates a table and files 10 words into table
words, count = getwords("dictionary.txt")
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

print(count.." words in table")

--Find a random index of the table, called "random_word"
math.randomseed(os.time()) --need to run first
random_index = math.random(1,words_length)

--prints random index and the word
print("Randomly picked "..random_index)
print(words[random_index])

--calculates the word_length
word_length = string.len( words[random_index] )
print("Word size is "..word_length)

--[[
Since we have word length, can't we just make a for loop? Would that be it,
yeah but we are going to need some if's and booleans (probably) to keep track
of what letters have been correctly guessed to reveal them
this is gonna need to be a function i think

Also this is how you block comment

--]]

show_letter = {} --better name for this variable??
for i = 1, word_length do --this initalized them to false
    show_letter[i] = false
end

letters_guessed = {}

wrong_ct = 0
correct_ct = 0
word = words[random_index]

function print_wrong(letters_guessed, wrong_ct)
    print("Guessed incorrect letters:")
    for i = 0, wrong_ct-1 do
        io.write(letters_guessed[i].." ")
    end
end

--I made the line printing a function that calls gallow with the attempt
--We could probably make a game function and just have the game in a loop
while (wrong_ct < 6) and (correct_ct < string.len(word)) do
    gallow(wrong_ct)
    io.write("Your word is:\n")
    for i = 1, string.len(word) do
        if show_letter[i] then
            io.write(string.sub(word,i,i).." ")--here we would print the ith character
        else
            io.write("_ ")
        end
    end
    print()
    print_wrong(letters_guessed, wrong_ct)
    print()

    io.write("Please guess a letter: ")
    ch = io.read(2);
    ch = string.upper(string.sub(ch,1,1) )
    char_found = false;
    char_unique = false;
    while not char_unique do
        char_unique = true
        for k = 0, wrong_ct do
            if letters_guessed[k] == ch then
                io.write("You already guessed that, input a new letter:")
                ch = io.read(2);
                ch = string.upper( string.sub(ch,1,1) )
                char_unique = false
            end
        end
    end
    for i = 1, string.len(word) do
        if string.upper(string.sub(word,i,i)) == ch then --compares character in word to user input
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
else print("Sorry, you lost!")
end
print()

--TODO:
-- import dictionary file into table (after we make sure it works on 10 words)
