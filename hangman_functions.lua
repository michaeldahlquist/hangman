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
    return new_table, count
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
--as well as the gallow. It is updated as the user makes guesses in hangman.lua
  a = ""
  b = ""
  c = " "
  d = ""
  e = ""
  f = ""
  if num < 5 then print("You have "..6-num.." attempts left") end
  if num >= 1 then a = "O" end
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

function gallow_test()
--gallow_test(num) prints all prossible attempts leves (0-6)
  for i = 0, 6 do
    print("gallow("..i.."):")
    gallow(i)
  end
end
