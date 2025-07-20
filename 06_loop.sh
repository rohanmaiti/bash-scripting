 # printing files in the current directory 

for file in $(ls);
do
echo "$file"
done

echo "--------"
 # printing all files using globbing 
for file in *;
do 
echo "$file"
done

echo "--------"
# print all the .md files
for file in *.md;
do 
echo "$file"
done


