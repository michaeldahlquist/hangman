--Michael Dahlquist & Kristen Qako
--csci324 - spring2020
--File: "hangman.lua"
-- //Description here

-- add functions
dofile('hangman_functions.lua')

--
--START OF PROGRAM
--

print("Hello user, welcome to hangman")

words = {}  --table to hold all words
--will eventually use "dictionary.txt" contents
words[0] = "apple"
words[1] = "banana"
words[2] = "cactus"
words[3] = "dog"
words[4] = "empty"
words[5] = "food"
words[6] = "google"
words[7] = "hello"
words[8] = "indigo"
words[9] = "jumping"

words_length = tableLength(words) --size of table
print(words_length)

--Test
gallow_test()
