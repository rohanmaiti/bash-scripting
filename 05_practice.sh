#!/bin/bash

echo "Enter a number"
read number
my_array=()
for (( i = 0; i< number; i++ ))
do
echo "Enter item $((i+1)):"
read item
my_array+=("$item")
done

# show the array
echo "my_array = ${my_array[@]}"

