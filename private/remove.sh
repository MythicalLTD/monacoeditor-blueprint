#!/bin/bash

DATA_DIRECTORY="{root/data}"

WEBPACK_PATH="$PTERODACTYL_DIRECTORY/webpack.config.js"
WEBPACK_PATH_BAK="$PTERODACTYL_DIRECTORY/webpack.config.js.bak"

FILE_CONTAINER_PATH="$PTERODACTYL_DIRECTORY/resources/scripts/components/server/files/FileEditContainer.tsx"
FILE_CONTAINER_PATH_BAK="$PTERODACTYL_DIRECTORY/resources/scripts/components/server/files/FileEditContainer.tsx.bak"

echo -e "\n\x1b[35;1m
 ███▄ ▄███▓▓██   ██▓▄▄▄█████▓ ██░ ██  ██▓ ▄████▄   ▄▄▄       ██▓    
▓██▒▀█▀ ██▒ ▒██  ██▒▓  ██▒ ▓▒▓██░ ██▒▓██▒▒██▀ ▀█  ▒████▄    ▓██▒    
▓██    ▓██░  ▒██ ██░▒ ▓██░ ▒░▒██▀▀██░▒██▒▒▓█    ▄ ▒██  ▀█▄  ▒██░    
▒██    ▒██   ░ ▐██▓░░ ▓██▓ ░ ░▓█ ░██ ░██░▒▓▓▄ ▄██▒░██▄▄▄▄██ ▒██░    
▒██▒   ░██▒  ░ ██▒▓░  ▒██▒ ░ ░▓█▒░██▓░██░▒ ▓███▀ ░ ▓█   ▓██▒░██████▒
░ ▒░   ░  ░   ██▒▒▒   ▒ ░░    ▒ ░░▒░▒░▓  ░ ░▒ ▒  ░ ▒▒   ▓▒█░░ ▒░▓  ░
░  ░      ░ ▓██ ░▒░     ░     ▒ ░▒░ ░ ▒ ░  ░  ▒     ▒   ▒▒ ░░ ░ ▒  ░
░      ░    ▒ ▒ ░░    ░       ░  ░░ ░ ▒ ░░          ░   ▒     ░ ░   
    ░    ░ ░               ░  ░  ░ ░  ░ ░            ░  ░    ░  ░
         ░ ░                          ░                          
         
\x1b[0m"

echo -e "
\x1b[35;1m┃  Welcome to MoncaoEditor Blueprint Uninstaller! 
\x1b[35;1m┃\x1b[0m
\x1b[35;1m┃\x1b[0m This script will uninstall Moncao Editor and restore
\x1b[35;1m┃\x1b[0m the original files.
"
sleep 5

# Restore old files if they exist
if [ -f "$WEBPACK_PATH_BAK" ]; then
    mv "$WEBPACK_PATH_BAK" "$WEBPACK_PATH"
    echo -e "\n\x1b[2;1m┃\x1b[0;2m Restored original webpack.config.js \x1b[0m"
fi

if [ -f "$FILE_CONTAINER_PATH_BAK" ]; then
    mv "$FILE_CONTAINER_PATH_BAK" "$FILE_CONTAINER_PATH"
    echo -e "\n\x1b[2;1m┃\x1b[0;2m Restored original FileEditContainer.tsx \x1b[0m"
fi

# Remove installed dependencies
echo -e "\n\x1b[2;1m┃\x1b[0;2m Removing installed dependencies... \x1b[0m"
cd "$PTERODACTYL_DIRECTORY"
yarn remove esbuild-loader monaco-editor @monaco-editor/react > /dev/null 2>&1
echo -e "\n\x1b[2;1m┃\x1b[0;2m Dependencies removed successfully. \x1b[0m"

echo -e "\n\x1b[2;1m┃\x1b[0;2m Building the project... \x1b[0m"

# Build the project
yarn build:production

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo -e "\n\x1b[2;1m┃\x1b[0;2m Build successful! \x1b[0m"
else
    echo -e "\n\x1b[2;1m┃\x1b[0;2m Build failed. Please check the logs for more information. \x1b[0m"
fi

# Restart the panel
echo -e "\n\x1b[2;1m┃\x1b[0;2m Restarting the panel... \x1b[0m"
cd $PTERODACTYL_DIRECTORY

php artisan view:clear
php artisan config:clear
php artisan cache:clear
php artisan queue:restart
php artisan up

echo -e "\n\x1b[2;1m┃\x1b[0;2m Uninstallation complete! \x1b[0m"
