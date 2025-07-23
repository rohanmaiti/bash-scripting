# Accepts a file extension like .sh, .py, .js
# Prints: "This is a Bash script" or "This is a Python script" etc.
#!/bin/bash
echo "Enter file name: "
read file

case $file in 
*.py)
   echo "this is a python file" ;;
*.sh)
   echo "this is a bash file" ;;
*.js)
   echo "this is a js file" ;;
*)
   echo "unknow file type" ;;
esac



logfile="log.txt"
echo "Logging started at $(date)" > $logfile

for i in {1..5}
do
  echo "Log entry $i at $(date)" >> $logfile
  sleep 1
done

echo "Done. Logs saved to $logfile"

