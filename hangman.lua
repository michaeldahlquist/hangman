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
print("gallow(0):")
gallow(0)
print("gallow(1):")
gallow(1)
print("gallow(2):")
gallow(2)
print("gallow(3):")
gallow(3)
print("gallow(4):")
gallow(4)
print("gallow(5):")
gallow(5)
print("gallow(6):")
gallow(6)
