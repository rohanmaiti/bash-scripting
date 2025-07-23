# 💡 Challenge: User Info Validator
# Goal:
# Write a Bash script that:
# Asks the user for their name and age.
# Validates that:
# Name is not empty
# Age is not empty and is a number.
# Age must be ≥ 18.
# Prints appropriate messages for each case.

#🧪 Sample Input/Output:
# $ ./userinfo.sh
# Enter your name: 
# ❌ Name cannot be empty.

# $ ./userinfo.sh
# Enter your name: Rohan
# Enter your age: seventeen
# ❌ Age must be a number.

# $ ./userinfo.sh
# Enter your name: Rohan
# Enter your age: 16
# 🛑 You are underage.

# $ ./userinfo.sh
# Enter your name: Rohan
# Enter your age: 21
# ✅ Access granted, Rohan!


#!/bin/bash
read -p "Enter your name : " name
if [[ -z $name ]]; then
  echo "Name can't be empty"
  exit 0
fi

read -p "Enter your age : " age
if [[ -z $age || ! $age =~ ^[0-9]+$ ]]; then
  echo "Age can't be empty or must contain only digits"
  exit 0
fi

if (( age >= 18 )); then
  echo "access granted"
else
  echo "you are underage"
fi

