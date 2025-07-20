#!/bin/bash

# syntax-1 

echo "Enter your age:"
read age
if [[ "$age" -gt 18 ]]
then 
echo "You are adult"
echo "You can drive"
else 
echo "You are underage"
echo "You can't drive"
fi

# syntax-2
echo "Enter you name: "
read name
echo "Enter your password: "
read password

if (( 1 )); then 
 echo "Your name is $name and password is $password"
else 
 echo "wrong password"
fi


echo "Enter file name: "
read filename
if [[ -e "$filename" ]]
then
echo "File exists"
else
ehco "File not exists"
fi


