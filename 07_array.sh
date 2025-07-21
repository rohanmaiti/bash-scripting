#!/bin/bash

# delcaring empty array 
arr=()

# initialising a array at compile time 
arr=(red green "word with sapce" yellow)

# print array elemetns 
for (( i=0; i<${#arr[*]}; i++ ));
do
echo "item $((i+1)) = ${arr[$i]}"
done

# now taking input in the array 
echo "Enter number of input you want :"
read size 
for (( i=1; i<=$size; i++));
do
echo "Enter item $i: "
read item
arr+=("$item")
done

# printing the items 
echo "Priting all array items = ${arr[@]}"
# printing individual index
echo "Priting index 2 of array = ${arr[1]}"


# adding elemennt at run time 
# printing the array whole 
echo "Priting the array whole ${arr[*]}"

# priting perticular index
echo "Printing perticular index ${arr[2]}"

# printing index ie out of bound 
echo "Printing index ie out of bound ${arr[40]}"

# removing a index of array and printing the array
unset arr[2]
echo "Printing array after removing index-2"

# priting array by iterating 
for (( i=0;i<"${#arr[@]}";i++ ));
do 
echo "$((i+1))  element = ${arr[$i]}"
done

# priting length of array 
echo "Print length of array is = ${#arr[@]}"

# Assosiative Arrays
# step-1 : Declare the array 
declare -A colors
colors=(
[name]="Rohan"
[age]=21
)

# assigning individual items 
colors["city"]="Kolkata"
colors[pin]=721144

# priting the whole dictionary using loop

for key in "${!colors[@]}";
do
echo "key-> $key: ${colors[$key]}"
done






