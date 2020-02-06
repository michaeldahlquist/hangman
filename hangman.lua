--Michael Dahlquist & Kristen Qako
--csci324 - spring2020
--File: "hangman.lua"
-- //Description here

-- add functions
dofile("hangman_functions.lua")

--START OF PROGRAM

print("Hello user, welcome to hangman")

--This section creates a table and files 10 words into table
words = {}  --table to hold all words
--will eventually use "dictionary.txt" contents
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

--Calculate the size of the table
table_size = tableLength(words) --size of table
print(table_size.." words in table")

--Find a random index of the table, called "random_word"
math.randomseed(os.time()) --need to run first
random_index = math.random(1,table_size)

--prints random index and the word
print("Randomly picked "..random_index)
print(words[random_index])

--calculates the word_length
word_length = string.len( words[random_index] )
print("Word size is "..word_length)

--Since we have word length, can't we just make a for loop? Would that be it,
--yeah but we are going to need some if's and booleans (probably) to keep track
--of what letters have been correctly guessed to reveal them
--this is gonna need to be a function i think
word_guessed = {}
for i = 0, word_length do --this initalized them to false
    word_guessed[i] = false
end

--I think this loop needs to go into the gallow function, that way
--we print the gallow and the current word guessing
for i = 0, word_length do
    if word_guessed[i] then
        --here we would print the ith character
    else
        io.write(" _")
    end
end
print()

--TODO:
-- import dictionary file into table (after we make sure it works on 10 words)
-- write user guessing
-- check letter against each character
-- change letters to all upper case?
-- show letters guessed when gallow printed
