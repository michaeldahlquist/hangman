--Michael Dahlquist & Kristen Qako
--csci324 - spring2020
--File: "hangman.lua"
-- //Description here

-- add functions
dofile("hangman_functions.lua")

--START OF PROGRAM

print("Hello user, welcome to hangman")

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

words_length = tableLength(words) --size of table
print(words_length.." words in table")

math.randomseed(os.time()) --need to run first
random_word = math.random(1,words_length)

print("Randomly picked "..random_word)
print(words[random_word])
