#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
echo 'INFO - @Backup-Restore Main Menu' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
wp=$( cat /var/plexguide/wp.id )

export NCURSES_NO_UTF8_ACS=1
HEIGHT=13
WIDTH=52
CHOICE_HEIGHT=6
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="Backup & Restore Menu"
MENU="Current Server Focus: $wp"

OPTIONS=(A "Deploy New WP Server"
         B "Change Server ID"
         C "Backup Current WP Server"
         D "Restore WP Server: $id"
         Z "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
  
case $CHOICE in
        A)
echo 'INFO - Selected: Deploy a New WP Server' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
            bash /opt/plexguide/menus/wordpress/deploywp.sh 
            ;;
        B)
echo 'INFO - Selected: Change Server ID' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
            bash /opt/plexguide/menus/backup-restore/restore.sh
            ;;
        C)
echo 'INFO - Selected: Backup Current WP Server' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
            bash /opt/plexguide/menus/backup-restore/backupmass.sh 
            ;;
        D)
            bash /opt/plexguide/menus/backup-restore/restoremass.sh
            ;;
        E) 
            bash /opt/plexguide/menus/backup-restore/recovery.sh
            ;;
        Z)
            clear
            exit 0
            ;;

esac
bash /opt/plexguide/menus/backup-restore/main.sh