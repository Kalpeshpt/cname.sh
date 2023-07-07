#!/bin/bash

# Check if the list file is provided as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <list_file>"
  exit 1
fi

# Retrieve the list file from the first argument
list_file=$1

# Check if the list file exists
if [ ! -f "$list_file" ]; then
  echo "List file not found: $list_file"
  exit 1
fi

# Read each line (domain) from the list file
while IFS= read -r domain; do
  # Query the CNAME record using dig command
  cname=$(dig +short CNAME $domain)

  # Check if the CNAME record exists
  if [ -z "$cname" ]; then
    echo "No CNAME record found for $domain."
  else
    echo "CNAME record for $domain: $cname"
  fi
done < "$list_file"
