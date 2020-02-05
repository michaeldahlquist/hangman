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

function gallow(num)
    a = ""
    b = ""
    c = " "
    d = ""
    e = ""
    f = ""
    if num >= 1 then a = "0" end
    if num >= 2 then b = "|" end
    if num >= 3 then c = "/" end
    if num >= 4 then d = "\\" end
    if num >= 5 then e = "/" end
    if num == 6 then f = "\\" end
    print("    ___________")
    print("    |         |")
    print("    |         "..a)
    print("    |        "..c..b..d)
    print("    |        "..e.." "..f)
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("    |          ")
    print("____|____")
end