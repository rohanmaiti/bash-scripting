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
echo $ans # ✅ Output the value
}

result=$(sum 10 30)
echo "result is = $result"


check_even() {
  local num=$1
  if (( num % 2 == 0 )); then
    return 0  # success
  else
    return 1  # failure
  fi
}

check_even 10
if [ $? -eq 0 ]; then
  echo "Even"
else
  echo "Odd"
fi


# question --> reverse_string: Takes a string and prints it reversed

function reverse_string {
local string=$1
local reverse=""
local ans=""
for ch in $string;
do
ans=$ch+$ans
done
echo "$ans"
}

result2=$(reverse_string abcdef)
echo "result = $result2"



