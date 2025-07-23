#!/bin/bash
echo "Enter fruit name: "
read fruit

case $fruit in 
apple)
  echo "Apples are red or green" ;;
banana)
  echo "Bananas are yellow" ;;
mango) 
  echo "mangoes are sweet" ;;
*)
  echo "Unknow fruit" ;; 
esac

