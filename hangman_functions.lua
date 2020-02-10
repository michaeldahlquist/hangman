--[[
Names: Michael Dahlquist & Kristen Qako
Class: csci324 - spring2020
File: "hangman_functions.lua"
Program Description: These are the functions for the game of hangman.
--]]

function getwords(file_name)
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


function tableLength(thisTable)
  --this function was found at the following url
  --https://www.quora.com/How-do-I-get-the-number-of-elements-in-an-array-with-Lua
  counter = 0
  for each in pairs(thisTable) do
    counter = counter+1
  end
  return counter
end

function gallow(num)
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
  for i = 0, 6 do
    print("gallow("..i.."):")
    gallow(i)
  end
end
