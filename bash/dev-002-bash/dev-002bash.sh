#!/bin/bash
# Set Color
GREEN="\033[0;32m"
RED='\033[0;31m'

NUMBER=12
INTERVAL=5
SUCCESS=1

function help {
  cat <<EOL
Usage: $0 [OPTIONS] COMMAND

Available Options:
    -n: Number of tries (Default: 10)
    -i: Interval second (Deafult: 15)
Examples: 
  $0 -n 3 -i 2 COMMAND
  $0 -i 5 COMMAND
EOL
}

function check_number {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    return 0
  else
    return 1
  fi
}

if [[ $# -eq 0 ]]; then
  echo -e "\033[0;31mEnter a Command\033[0m"
  help
  exit 0
fi

while [[ $# -ne 0 ]]; do
  case $1 in
  -n)
    unset TRY_NUMBER
    check_number $2
    if [[ $? -ne 0 ]]; then
      echo -e "\033[0;31mEnter Try Number\033[0m"
      help
      exit 1
    fi
    NUMBER=$2
    shift 2
    ;;
  -i)
    unset TRY_INTERVAL
    check_number $2
    if [[ $? -ne 0 ]]; then
      echo -e "\033[0;31mEnter Try Interval\033[0m"
      help
      exit 1
    fi
    INTERVAL=$2
    shift 2
    ;;
  *)
    COMMAND=$@
    break
    ;;
  esac
done

if [[ -z $COMMAND ]]; then
  echo -e "\033[0;31mEnter a Command\033[0m"
  help
  exit 0
fi

# ENVIORMENT VARIABLE
set TRY_INTERVAL
set TRY_NUMBER

# Validate ENV or Set Default
if [ ! -z $TRY_INTERVAL ]; then
  INTERVAL=$TRY_INTERVAL
fi
if [ ! -z $TRY_NUMBER ]; then
  NUMBER=$TRY_NUMBER
fi

for i in $(seq 1 $NUMBER); do
  ($COMMAND) 2>/dev/null
  if [[ $? -eq 0 ]]; then
    SUCCESS=0
    break
  else
    echo -e "Try $i for execute \033[0;34m$COMMAND\033[0m failed. Sleep for $INTERVAL second..."
    sleep $INTERVAL
  fi
done

if [[ $SUCCESS -eq 0 ]]; then
  echo -e "${GREEN}Command got executed successfully."
  exit 0
else
  echo -e "${RED}Threshold reached and Command opration failed." 1>&2
  exit 1
fi
