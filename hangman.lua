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
