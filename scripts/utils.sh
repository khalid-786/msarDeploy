
#!/bin/bash
separator(){

echo "------------------------------------------------"

}

require_command(){

command -v "$1" >/dev/null 2>&1 || {

log_error "$1 is not installed."

exit 1

}

}

file_exists(){

if [ ! -f "$1" ]
then

log_error "$1 not found."

exit 1

fi

}