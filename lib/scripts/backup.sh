#!/bin/bash

# copy to local backups folder
cd "$HOME/green/db/" || exit
today=$(date '+%Y_%m_%d__%H_%M_%S')
cp "production.sqlite3" "$HOME/backups/green/green_$today.db"

# backup to gdrive
sleep 1
gdrive push -quiet -destination "/" "$HOME/backups/green"

# delete archives older than 7 days from disk
sleep 1
find "$HOME/backups/green/" -type f -mtime +7 -exec rm {} \;
