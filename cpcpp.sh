#!/bin/bash

BLUE='\033[1;36m'
DARK_BLUE='\033[1;34m'
GREEN='\033[1;32m'
ORANGE='\033[38;5;208m'
RED='\033[1;31m'
NC='\033[0m'

if [ $# -lt 1 ]; then
  echo "Usage: cpcpp <filename> <flags: [-r, -b]> <additional g++ flags>"
  exit 1
fi

filename=$1
output="${filename%.*}"

build_set=0
run_set=0
tests=1
flags=1
args=("$@")

# Check if -b flag is present anywhere in the arguments
if [[ " $@ " =~ " -b " ]]; then
  build_set=1
  flags=$(( $flags + 1 ))
  args=("${args[@]/-b/}")
fi

# Check if -r flag is present anywhere in the arguments
if [[ " $@ " =~ " -r " ]]; then
  run_set=1
  flags=$(( $flags + 1 ))
  args=("${args[@]/-r/}")
fi

# Check if --tests= is present anywhere in the arguments
for i in "${!args[@]}"; do
  if [[ "${args[i]}" =~ --tests= ]]; then
    tests="${args[i]#*=}"
    flags=$(( $flags + 1 ))
    unset 'args[i]'
    break
  fi
done

color_output() {
  local cmd="$@"
  $cmd | while IFS= read -r line; do
    echo -e "$BLUE$line$NC"
  done
}

build() {
  # Default compiling command with optimization level 2
  local cmd="g++ -O2 -Wall -lm -std=c++20 $filename -o $output"
  
  if [ ${#args[@]} -gt $flags ]; then
    local additional_flags="${args[@]:1}"
    cmd="g++ $filename -o $output$additional_flags"
  fi

  # Compiling
  echo -e "${BLUE}${cmd}${NC}"
  eval $cmd

  # Check if compilation was successful
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}Compilation completed.${NC}"
  else
    echo -e "${RED}Compilation failed.${NC}"
    exit 1
  fi
}

run() {
  if [ -f "$output" ]; then
    if [ $tests -lt 2 ]; then
      color_output ./"$output"
      exit 0
    fi

    (
      for ((i=1; i<=$tests; i++)); do
        echo -e "${DARK_BLUE}###Test $i:${NC}"
        color_output ./"$output"
      done
    )
    exit 0
  else
    echo -e "${RED}Executable not found. Please build and run:\n${BLUE}cpcpp <filename> <flags: [-r, -b]> <additional g++ flags>${NC}"
    exit 1
  fi
}

if [ $build_set -eq $run_set ]; then
  build
  run
elif [ $build_set -eq 1 ]; then
  build
elif [ $run_set -eq 1 ]; then
  run
fi
