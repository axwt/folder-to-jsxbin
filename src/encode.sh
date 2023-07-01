#!/bin/bash

# Check if argument was provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Please provide the path to the folder with JSX files."
    exit 1
fi

export PATH=/usr/local/bin:$PATH && which node
# NODE_BIN=$(which node)
# Get the current username
USER_NAME=$(whoami)

# Path to the exportToJSXBin.js script
EXTENSION_DIR=$(ls /Users/${USER_NAME}/.vscode/extensions/ | grep "adobe.extendscript-debug-")
EXPORT_SCRIPT_PATH="/Users/${USER_NAME}/.vscode/extensions/${EXTENSION_DIR}/public-scripts/exportToJSXBin.js"
NODE_BIN="/Users/${USER_NAME}/.nvm/versions/node/v14.21.3/bin/node"

# Error log file
ERROR_LOG="/Users/${USER_NAME}/Desktop/JSXBIN_errors.log"

# Directory containing jsx files to convert
SOURCE_DIR="$1"

# Creating a new directory with "encoded" at the end
ENCODED_DIR="${SOURCE_DIR}_encoded"

# Check is correct Node version exists
if test -f "$NODE_BIN"; then
    echo "NODE_BIN directory exists"
else

USER_RESPONSE=$(osascript <<EOF
set dialogResult to "OK"
try
    display dialog "Node.js version 14.21.3 is not found. You need to install NVM and Node.js v14.21.3. Please check Quick Action manual here: https://github.com/axwt/folder-to-jsxbin" buttons {"Cancel", "OK"} default button "OK"
on error
    set dialogResult to "Cancel"
end try
return dialogResult
EOF
)
    echo "Node.js version 14.21.3 is not found" >> "$ERROR_LOG"
    echo "NODE_BIN directory does not exist"
    exit 1;
fi


# Start processing folder/files

nvm use v14.21.3

mkdir -p "$ENCODED_DIR"

# Copying the original directory into the new one
cp -r "$SOURCE_DIR"/* "$ENCODED_DIR"

# Boolean flag to track if any error occurred
ERROR_OCCURRED=false

# Total number of .jsx files to convert
JSX_FILE_COUNT=$(find "$ENCODED_DIR" -name '*.jsx' -type f | wc -l | tr -d '[:space:]')

# Finding and converting each .jsx file recursively in all subdirectories
COUNTER=0
find "$ENCODED_DIR" -name '*.jsx' -type f | while read file; do
  COUNTER=$((COUNTER + 1))
  osascript -e "display notification \"Processing file: $(basename "$file") ($COUNTER from $JSX_FILE_COUNT)\" with title \"Converting...\""
  echo "Converting $file to jsxbin..."
  echo $NODE_BIN "$EXPORT_SCRIPT_PATH" -f -n "$file"
  OUTPUT=$($NODE_BIN "$EXPORT_SCRIPT_PATH" -f -n "$file" 2>&1)
  if ! echo "$OUTPUT" | grep -q "Success:"; then
    # Write the error output to a log file
    echo "Error converting $file:" >> "$ERROR_LOG"
    echo "$OUTPUT" >> "$ERROR_LOG"
    # Notify the user
    osascript -e 'display notification "Some errors occurred during conversion. See JSXBIN_errors.log on your Desktop." with title "Conversion Error"'
    ERROR_OCCURRED=true
  fi
  rm "$file"
done

# Checking if encoded directory is empty
if [ -z "$(ls -A "$ENCODED_DIR")" ]; then
   echo "Removing empty directory $ENCODED_DIR"
   rmdir "$ENCODED_DIR"
fi

# Write to log file if any error occurred
if $ERROR_OCCURRED ; then
  echo "" >> "$ERROR_LOG"
  echo "=====================================" >> "$ERROR_LOG"
  echo "Current Node.js version is $NODE_BIN" >> "$ERROR_LOG"
  echo "=====================================" >> "$ERROR_LOG"
  echo "" >> "$ERROR_LOG"
fi

# Showing the notification
osascript -e 'display notification "All .jsx files have been converted to .jsxbin and original jsx files have been removed." with title "Conversion Complete"'
