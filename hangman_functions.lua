--[[
Names: Michael Dahlquist & Kristen Qako
Class: csci324 - spring2020
File:  "hangman_functions.lua"
Program Description: These are the functions for the game of hangman.
                     This file is ran at the beginning of "hangman.lua" to
                     define all of the functions. Each function is further
                     described within itself.
--]]

function add_words_to_file(file_name)
--this function takes in two parameters, a string that is the file_name of 
--the destination file.
--this function:
--  a) prompts user whether they would like to add words to the file
--  b) takes in words from user, appends to front of table, and then
--     inserts entire table into file_name
    file_table = get_lines(file_name)
    io.write("Would you like to add any words to "..file_name.." ? (Y/N): ")
    ans = io.read("*line")
    ans = string.upper( string.sub(ans,1,1) )
    if ans == 'Y' then
        print("Please enter as many words as you like, seperating them by a new line.")
        print("To terminate, enter *")

        counter = 1 --decrements before first word add i.e., first word at table[0]
        io.write("Word: ")
        add_word = io.read("*line") --read first word
        while not (add_word  == '*') do --stop loop when "*"
            counter = counter - 1
            file_table[counter] = add_word
            io.write("Word: ")
            add_word = io.read("*line")
        end

        local file = io.open(file_name, "w+") --open file
        io.output(file) --set output to file
        for i = 0, counter, -1 do --write words added
            io.write(file_table[i]..'\n')
        end

        for i = 1, #file_table do --write original words
            io.write(file_table[i]..'\n')
        end
        print("normal table finished")
        file:close()
        print("file closed")
    else
        print("Have a nice day!")
    end
    
end



function get_lines(file_name)
--get_lines(file_name) returns a table and count of all the lines in file_name
--does not include return characters
    new_table = {}
    count = 0
    local file = io.open(file_name, "rb")
    for line in io.lines(file_name) do
        count = count + 1
        new_table[count] = string.sub(line, 1, string.len(line)-1)
    end
    file:close()
    return new_table
--A portion of this code was inspired by:
--https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
end

function gallow(num)
--These are the graphics for the game. It prints the remaining number of moves
--as well as the gallow. It is updated as the user makes incorrect guesses
    for i = 1, 25 do
        print() --add blank lines to keep the following at the bottom of shell
    end
    --os.execute("clear")
    a = ""
    b = ""
    c = " "
    d = ""
    e = ""
    f = ""
    if num < 5 then print("You have "..6-num.." incorrect attempts left") end
    if num >= 1 then a = "😔" end
    if num >= 2 then b = "|" end
    if num >= 3 then c = "/" end
    if num >= 4 then d = "\\" end
    if num >= 5 then e = "/" end
    if num == 5 then print("You have 1 attempt left") end
    if num == 6 then f = "\\" end
    print("    ___________")
    print("    |         |")
    print("    |         "..a)
    print("    |        "..c..b..d)
    print("    |        "..e.." "..f)
    print("    |")
    print("    |")
    print("    |")
    print("    |")
    print("    |")
    print("____|____")
end

function print_wrong(letters_guessed, wrong_ct)
--This function prints out the players incorrect letter guesses.
--It is in order of appearance.
    print("Guessed incorrect letters:")
    for i = 0, wrong_ct-1 do
        io.write(letters_guessed[i].." ")
    end
end

function hangman (words)
--This function plays the entire game of hangman. It take in one parameter
--that is a table of words, indexed 1 through n number of words. A random
--word is selected and the user must guess the letters in the word, losing
--at the sixth incorrect guess. This function returns two boolean values,
--whether the user wants to play_again, or if the game_won.

    --START THE GAME OF HANGMAN:

    --This section finds a random index of the table, meaning the word is randomly picked.
    math.randomseed(os.time()) --initalize random seed with os.time()
    random_index = math.random(1,#words) -- #words => size of words
    word = words[random_index]

    --Declare an empty table that will store the users guesses.
    letters_guessed = {}

    wrong_ct = 0 --number of times user guessed wrong
    correct_ct = 0--number of times user guessed correctly
    word = words[random_index]

    --This initializes each letter of the word to false as a way to test if the
    --user inputs a correct letter later in the code.
    show_letter = {} --better name for this variable??
    for i = 1, string.len(word) do --this initalized them to false
        show_letter[i] = false
        if string.gsub(string.sub(word,i,i), "%A", "*") == "*" then
            --this will show all non-letter characters in the word
            show_letter[i] = true
        end
    end

    --This loop is what runs guessing portion of the game
    while wrong_ct < 6 and correct_ct < string.len(word) do
    --this while loop runs until the man is hanged or the user gets the word.
        gallow(wrong_ct)
        io.write("Your word is:\n")
        for i = 1, string.len(word) do --prints underscore for hidden letters and
            if show_letter[i] then     --prints the letters if guessed correctly
                io.write(string.sub(word,i,i).." ")--we would print the ith character
            else
                io.write("_ ") --print underscore's for each letter not guessed.
            end
        end
        print()
        print_wrong(letters_guessed, wrong_ct)
        print()

        --This section of code takes users guesses and checks whether a wrong input
        --has been guessed before. We decided that letters that have been shown
        --should not display that output and we just continue to show the current game.
        io.write("Please guess a letter: ")
        ch = io.read("*line"); --reads the entire line for inital guess
        ch = string.upper(string.sub(ch,1,1) ) --take upper of first character
        char_found = false;
        char_unique = false;
        while not char_unique do
        --this loop checks to make sure that this guess is valid...
        --i.e., not already guessed, not a space
            char_unique = true
            for k = 0, wrong_ct do -- This loop checks if already incorrect guess
                if letters_guessed[k] == ch then --checks if letter has been guessed
                    io.write("You already guessed that, input a new letter:")
                    ch = io.read("*line");
                    ch = string.upper( string.sub(ch,1,1) )
                    char_unique = false
                end
            end
            for i = 1, string.len(word) do -- This loop checks if already correct guess
                if string.upper(string.sub(word,i,i)) == ch and show_letter[i] then
                    io.write("That letter is already in the word, input new letter: ")
                    ch = io.read("*line");
                    ch = string.upper( string.sub(ch,1,1) )
                    char_unique = false
                end
            end
            --[[
            if ch == '1' or ch == '2' or ch == '3' or ch == '4' or ch == '5' or
               ch == '6' or ch == '7' or ch == '8' or ch == '9' or ch == '0' or
               ch == ' ' or ch == "\'" then
                ]]
            if string.gsub(ch, "%A", "*") == "*" --not a character
               or string.len(ch) == 0 -- if only enter was the input, len is 0 
               then
                --This check for space, apostrophe, or number
                -- Still need to if just hits enter
                io.write("Invalid character, input new letter: ")
                ch = io.read("*line");
                ch = string.upper( string.sub(ch,1,1) )
                char_unique = false
            end
        end
     --This section of code checks whether the user input is correct. If it is
     --correct, we make that index of the word true, then increment the number of
     --correctly counted words.
        for i = 1, string.len(word) do
            --compares letter in word to the users guess
            if string.upper(string.sub(word,i,i)) == ch then
                if show_letter[i] then
                    char_found = true
                else
                    char_found = true
                    show_letter[i] = true
                    correct_ct = correct_ct + 1
                end
            end
        end

        if not char_found then
            letters_guessed[wrong_ct] = ch
            wrong_ct = wrong_ct + 1
        end
        print()
    end --end while loop

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

    if wrong_ct < 6 then
        game_won = true
        print("Congratulations, you guessed the word!")
    else
        game_won = false
        print("Sorry, you lost! The word was: ", word)
    end
    print()

    --END THE GAME OF HANGMAN

    --Here we prompt if the game should be played again
    valid_response = false
    while not valid_response do
        io.write("Would you like to play another round? Yes or No: ")
        ch = io.read("*line")
        ch = string.upper( string.sub(ch,1,1) )
        --only care about the first letter of yes, yeah, no, nah, quit, etc.
        if ch == 'Y' then
            play_again = true
            valid_response = true
        elseif ch == 'N' or ch == 'Q' then
            play_again = false
            valid_response = true
        else --if did not start with y or n, prompt again
            valid_response = false
            io.write("Invalid response. ")
        end
    end
    return play_again, game_won
end
