#!/bin/bash
# syntax-1 of writing function
function greet_user {
echo "Hello $1"
}
# calling the function with one arguments
greet_user Rohan


# syntax-2 of writing function 
hello_user () {
echo "Hello $1"
echo "All arguments $@"
echo "No of arguments = $#"
}

hello_user Kalyani rohan rahul

function sum {
local ans=$(( $1 + $2 ))
echo "sum of $1 + $2 = $ans"
echo "sum function is executing "
return $ans
}

result=$(sum 10 30)
echo "result is = $result"

