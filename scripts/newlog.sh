#!/bin/zsh

## TODO: Check for flags (quick actions)

file_name="log-entry"
formatted_file_name=$(date "+%Y-%m-%d")_${file_name}.md
cd $VAULT_PATH || exit

file_path = "log/${formatted_file_name}"

# If the file does not already exist we'll write it
if [ ! -f file_path ]; then
  file_template = "
  ---\n
  date: $(date "+%Y-%m-%d")\n
  tags:\n
    - log \n
  hubs:\n
    - "[[Log]]"\n
  ---\n\n

  # ${formatted_file_name}\n\n

  "

  touch file_path
  printf file_template >> file_path
fi

# Then finally we'll handle quick action flags
while getopts "hvf:" flag; do
 case $flag in
   o) # Handle the -o flag: Open file
   nvim file_path
   ;;
   p) # Handle the -p flag with an argument: Write line to file
   argument=$OPTARG
   content="\n${argument}\n"
   printf content >> file_path
   ;;
   \?)
   # Handle invalid options
   echo "Error: Invalid flag option"
   ;;
 esac
done
