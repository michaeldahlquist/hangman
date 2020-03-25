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
        --print("normal table finished")
        file:close()
        --print("file closed")
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
        --fixes formatting issues
        line1 = line
        line1 = string.gsub(line1, "%A", "*")
        if string.sub(line1,string.len(line1),string.len(line1)) == "*" then
            line = string.sub(line,1,string.len(line1)-1)
        end
        new_table[count] = line
        --new_table[count] = string.sub(line, 1, string.len(line))
    end
    file:close()
    return new_table
--A portion of this code was inspired by:
--https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
end

function gallow(num)
--These are the graphics for the game. It prints the remaining number of moves
--as well as the gallow. It is updated as the user makes incorrect guesses
    if pcall(function () os.execute("clear") end) then 
        print()
    else 
        for i = 0, 30 do
            print()
        end
    end
    print("This is the game of hangman!")
    print()
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

function make_show()
    this_table = {}
    this_table[1] = true
    this_table[2] = false
    this_table[3] = true
    this_table[4] = false
    return this_table
end

function hint(show_letter)
--This function is for extra credit.
--This function takes in the table of the letters shown 
--It prompts the user to chose an index of the word to show [1,n]
--There is a while loop to check that index is valid and has not been shown.
--It then modifies the show_letter table at character k to be true.
    io.write("Which index [1,"..#show_letter.."] would you like to show?: ")
    num = io.read("*number")
    while  num < 1 or num > #show_letter or show_letter[num] do
            io.write("Sorry, I can't reveal that...enter another: ")
            num = io.read("*number")
    end
    show_letter[num] = true
end

function hangman (words)
--This function plays the entire game of hangman. It take in one parameter
--that is a table of words, indexed 1 through n number of words. A random
--word is selected and the user must guess the letters in the word, losing
--at the sixth incorrect guess. This function returns two boolean values,
--whether the user wants to play_again, and if the game_won.

    --START THE GAME OF HANGMAN:

    --This section finds a random index of the table, meaning the word is randomly picked.
    math.randomseed(os.time()) --initalize random seed with os.time()
    random_index = math.random(1,#words) -- #words => size of words
    word = words[random_index] --get word from table

    --Declare an empty table that will store the users guesses.
    letters_guessed = {}

    wrong_ct = 0 --number of times user guessed wrong
    correct_ct = 0--number of times user guessed correctly

    --This initializes each letter of the word to false as a way to test if the
    --user inputs a correct letter later in the code.
    show_letter = {} --table of bools, whether letter should be shown or not
    word1 = word
    for i = 1, string.len(word1) do --this initalized them to false
        show_letter[i] = false
        --true if character i is not a letter
        if string.gsub(string.sub(word1,i,i), "%A", "*") == "*" then
            --this will show all non-letter characters in the word
            show_letter[i] = true
            correct_ct = correct_ct + 1
        end
    end

    hints = 0

    --This loop is what runs guessing portion of the game
    while wrong_ct < 6 and correct_ct < string.len(word) do

        --DISPLAY WORD FOR ERROR CHECKING:
        io.write("THE WORD IS "..word)

        --total chars displayed:
        show_count = 0
        --total chars still hidden:
        hidden_count = 0

    --this while loop runs until the man is hanged or the user gets the word.
        gallow(wrong_ct) --gallow function prints current hanging state
        io.write("Your word is:\n")
        for i = 1, string.len(word) do --prints underscore for hidden letters and
            if show_letter[i] then     --prints the letters if guessed correctly
                io.write(string.sub(word,i,i).." ")--we would print the ith character
                show_count = show_count + 1
            else
                io.write("_ ") --print underscore's for each letter not guessed.
                hidden_count = hidden_count + 1
            end
        end
        print()
        print_wrong(letters_guessed, wrong_ct) --prints wrong letters
        print()

        --This percentage [0,100] is the max percent shown where the player will have the option
        --to show a hint
        percent_hint = 25
        
        if 100*show_count/string.len(word) <= percent_hint then
            hint_allowed = true
        else 
            hint_allowed = false
        end
        
        --This section of code takes users guesses and checks whether a wrong input
        --has been guessed before. We decided that letters that have been shown
        --should not display that output and we just continue to show the current game.
        if hint_allowed then
            print("You may enter '#' for a hint...")
        end
        io.write("Please guess a letter: ")
        ch = io.read("*line") --reads the entire line for inital guess
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
            --[[]]
            if ch == '#' then
                --user wants a hint
                if hint_allowed then 
                    hint(show_letter)
                    correct_ct = correct_ct + 1
                    char_found = true
                    hints = hints + 1
                else
                    io.write("Hints not allowed! Input your guess: ")
                    ch = io.read("*line");
                    ch = string.upper( string.sub(ch,1,1) )
                    char_unique = false
                end
            end
            --]]
            if string.gsub(ch, "%A", "*") == "*" --not a character
               or string.len(ch) == 0 -- if only enter was the input, len is 0 
               and not ch == '#'
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
