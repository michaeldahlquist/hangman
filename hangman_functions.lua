--[[
Names: Michael Dahlquist & Kristen Qako
Class: csci324 - spring2020
File: "hangman_functions.lua"
Program Description: These are the functions for the game of hangman.
                     This file is ran at the beginning of "hangman.lua" to
                     define all of the functions. Each function is further
                     described within itself.
--]]

function get_lines(file_name)
--A portion of this code was inspired by:
--https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
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
end

function table_size(this_table)
--this function was found at the following url:
--https://www.quora.com/How-do-I-get-the-number-of-elements-in-an-array-with-Lua
--table_size returns the count of all of the items in thisTable
    counter = 0
    for each in pairs(this_table) do
        counter = counter+1
    end
    return counter
end

function gallow(num)
--These are the graphics for the game. It prints the remaining number of moves
--as well as the gallow. It is updated as the user makes incorrect guesses
    for i = 1, 25 do
        print() --add blank lines to keep the following at the bottom of shell
    end
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
--This function plays the entrie game of hangman. It take in one parameter
--that is a table of words, indexed 1 through n number of words. A random
--word is selected and the user must guess the letters in the words, losing
--at the sixth incorrect guess. This function returns two boolean values,
--whether the user wants to play_again, or if the game_won.

    --START THE GAME OF HANGMAN:

    --calculate size of table
    words_length = table_size(words)

    --This section finds a random index of the table, meaning the word is randomly picked.
    math.randomseed(os.time()) --need to run first
    random_index = math.random(1,words_length)
    word = words[random_index]
    word_length = string.len( word )

    --Empty table that will store the users guesses.
    letters_guessed = {}

    wrong_ct = 0 --number of times user guessed wrong
    correct_ct = 0--number of times user guessed correctly
    word = words[random_index]

    --This initializes each letter of the word to false as a way to test if the
    --user inputs a correct letter later in the code.
    show_letter = {} --better name for this variable??
    for i = 1, word_length do --this initalized them to false
        show_letter[i] = false
        if string.sub(word,i,i) == "\'" then
            show_letter[i] = true
        end
    end


    --I made the line printing a function that calls gallow with the attempt
    --We could probably make a game function and just have the game in a loop

    --This function is what runs the game.

    while (wrong_ct < 6) and (correct_ct < string.len(word)) do
        --this while loop runs until the man in hanged or the user gets the word.
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

      --This section of code takes users guesses and checks whether a wrong input
      --has been guessed before. We decided that letters that have been shown
      --should not display that output and we just continue to show the current game.
        io.write("Please guess a letter: ")
        ch = io.read("*line"); --reads the input
        ch = string.upper(string.sub(ch,1,1) )
        char_found = false;
        char_unique = false;
        while not char_unique do
            char_unique = true
            for k = 0, wrong_ct do -- This loop checks if already incorrect guess
                if letters_guessed[k] == ch then --checks if letter has been guessed
                    io.write("You already guessed that, input a new letter:")
                    ch = io.read("*line");
                    ch = string.upper( string.sub(ch,1,1) )
                    char_unique = false
                end
            end
            for i = 1, word_length do -- This loop checks if already correct guess
                if string.upper(string.sub(word,i,i)) == ch and show_letter[i] then
                    io.write("That letter is already in the word, input new letter: ")
                    ch = io.read("*line");
                    ch = string.upper( string.sub(ch,1,1) )
                    char_unique = false
                end
            end
            if ch == ' ' or ch == '\0' then
                --This check for space, ??check for enter??
                print("THIS IS A SPACE OR ENTER")
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
                    show_letter[i] = true;
                    correct_ct = correct_ct + 1
                end
            end
        end

        if not char_found then
            letters_guessed[wrong_ct] = ch
            wrong_ct = wrong_ct + 1
        end
        print()
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

    if wrong_ct < 6 then
        game_won = true
        print("Congratulations, you guessed the word!")
    else
        game_won = false
        print("Sorry, you lost! The word was: ", word)
    end
    print()

    --END THE GAME OF HANGMAN

    --PROMPT IF THE GAME SHOULD BE PLAYED AGAIN

    io.write("Would you like to play another round? Yes or No: ")
    ch = io.read("*line")
    ch = string.upper( string.sub(ch,1,1) )
    if ch == 'Y' then
        play_again = true
    else
        play_again = false
    end
    return play_again, game_won
end
