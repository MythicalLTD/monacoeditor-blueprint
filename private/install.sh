#!/bin/bash

FILE_CONTAINER="https://raw.githubusercontent.com/MythicalLTD/monacoeditor-blueprint/refs/heads/main/pack/webpack.config.js"
WEBPACK_URL="https://raw.githubusercontent.com/MythicalLTD/monacoeditor-blueprint/refs/heads/main/ui/FileEditContainer.tsx"

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
\x1b[35;1m┃  Welcome to MoncaoEditor Blueprint! 
\x1b[35;1m┃\x1b[0m
\x1b[35;1m┃\x1b[0m Thanks for downloading Moncao Editor! We're
\x1b[35;1m┃\x1b[0m are so exited to have you here. If you have
\x1b[35;1m┃\x1b[0m any questions or need help, feel free to reach
\x1b[35;1m┃\x1b[0m us at any of the following:
\x1b[35;1m┃\x1b[0m
\x1b[35;1m┃ ☻ \x1b[0msupport@mythicalsystems.xyz
\x1b[35;1m┃ ☻ \x1b[0mhttps://github.com/mythicalltd/mythicaldash/issues
\x1b[35;1m┃ ☻ \x1b[0mhttps://discord.mythical.systems
"
sleep 5
echo -e "
\x1b[35;1m┃\x1b[0m
\x1b[35;1m┃\x1b[0m Credits to the original author:
\x1b[35;1m┃ ☻ \x1b[0mLeonardo R.
\x1b[35;1m┃ ☻ \x1b[0mhttps://builtbybit.com/resources/code-editor-for-pterodactyl.47572
"
sleep 5
echo -e "
\x1b[35;1m┃\x1b[0m
\x1b[35;1m┃\x1b[0m Blueprint directory:
\x1b[35;1m┃ ☻ \x1b[0m$PTERODACTYL_DIRECTORY
\x1b[35;1m┃ ☻ \x1b[0m$DATA_DIRECTORY
"
sleep 3
echo -e "\n\x1b[2;1m┃\x1b[0;2m Installing dependencies. \x1b[0m"
sleep 1
apt install wget curl sudo -y > /dev/null 2>&1
echo -e "\n\x1b[2;1m┃\x1b[0;2m Installed all dependencies. \x1b[0m"




# Rename old files if they exist
if [ -f "$WEBPACK_PATH" ]; then
    mv "$WEBPACK_PATH" "$WEBPACK_PATH_BAK"
    echo -e "\n\x1b[2;1m┃\x1b[0;2m Renamed existing webpack.config.js to webpack.config.js.bak \x1b[0m"
fi

if [ -f "$FILE_CONTAINER_PATH" ]; then
    mv "$FILE_CONTAINER_PATH" "$FILE_CONTAINER_PATH_BAK"
    echo -e "\n\x1b[2;1m┃\x1b[0;2m Renamed existing FileEditContainer.tsx to FileEditContainer.tsx.bak \x1b[0m"
fi
# Download the new files
wget -q "$FILE_CONTAINER" -O "$WEBPACK_PATH"
echo -e "\n\x1b[2;1m┃\x1b[0;2m Downloaded new webpack.config.js \x1b[0m"

mkdir -p "$(dirname "$FILE_CONTAINER_PATH")"
wget -q "$WEBPACK_URL" -O "$FILE_CONTAINER_PATH"
echo -e "\n\x1b[2;1m┃\x1b[0;2m Downloaded new FileEditContainer.tsx \x1b[0m"

# Set the node options
echo -e "\n\x1b[2;1m┃\x1b[0;2m Setting node options... \x1b[0m"
export NODE_OPTIONS=--openssl-legacy-provider
echo -e "\n\x1b[2;1m┃\x1b[0;2m Node options set successfully. \x1b[0m"

# Install the dependencies
echo -e "\n\x1b[2;1m┃\x1b[0;2m Installing dependencies... \x1b[0m"
cd "$PTERODACTYL_DIRECTORY"
yarn add esbuild-loader > /dev/null 2>&1
yarn add monaco-editor @monaco-editor/react > /dev/null 2>&1
echo -e "\n\x1b[2;1m┃\x1b[0;2m Dependencies added successfully. \x1b[0m"

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

echo -e "\n\x1b[2;1m┃\x1b[0;2m Installation complete! \x1b[0m"
