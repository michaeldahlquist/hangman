--Michael Dahlquist & Kristen Qako
--csci324 - spring2020
--File: "hangman_functions.lua"
-- //Description here


function tableLength(thisTable)
    --this function was found at the following url
    --https://www.quora.com/How-do-I-get-the-number-of-elements-in-an-array-with-Lua
    counter = 0
    for each in pairs(thisTable) do
      counter = counter+1
    end
    return counter
end
  
function gallow()
    print("    ___________")
    print("    |         |")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("____|____")
end