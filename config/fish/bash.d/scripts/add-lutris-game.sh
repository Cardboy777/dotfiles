#!/usr/bin/env bash

LUTRIS_CONFIG="$XDG_CONFIG_HOME/lutris/games"
LUTRIS_DB="$XDG_DATA_HOME/lutris/pga.db"

DESTINATION_STORAGE="/mnt/games"
SITE_DIR=${1:-"$DESTINATION_STORAGE/_staging"}

OG_EXE_RELATIVE=$(find "$SITE_DIR" -maxdepth 3 -type f | grep "\.exe" | fzf)

if [ -z "$OG_EXE_RELATIVE" ]; then
	exit 0
fi

OG_EXE=$(realpath "$OG_EXE_RELATIVE")

GAME_DIR=$(dirname "$OG_EXE")
SIMPLIFIED_NAME=$(basename "$GAME_DIR" | tr "[:upper:]" "[:lower:]" | tr " " "-" | tr "." "-" | sed 's/[^[:alnum:]-]//g')

NEW_DIR="$DESTINATION_STORAGE/$SIMPLIFIED_NAME/$(basename "$GAME_DIR")"

CWD=$NEW_DIR
EXE="$CWD/$(basename "$OG_EXE")"
WINE_PREFIX_DIR="$DESTINATION_STORAGE/$SIMPLIFIED_NAME/compatdata"

TRANSLATED_NAME=$(echo "$SIMPLIFIED_NAME" | tr "-" " " | trans -b - | sed 's/[^[:alnum:]-]//g')
SLUG=$(echo "$TRANSLATED_NAME" | tr " " "-" | tr "[:upper:]" "[:lower:]")
INSTALLED_AT=$((1 + $(sqlite3 "$LUTRIS_DB" "SELECT (MAX(installed_at)) FROM GAMES")))
CONFIG_PATH="$SLUG-$INSTALLED_AT"

mkdir -p "$NEW_DIR" "$WINE_PREFIX_DIR"
mv "$GAME_DIR" "$DESTINATION_STORAGE/$SIMPLIFIED_NAME"

cat >"$LUTRIS_CONFIG/$CONFIG_PATH.yml" <<EOF
game:
  exe: $EXE
  prefix: $WINE_PREFIX_DIR
  working_dir: $CWD
EOF

sqlite3 "$LUTRIS_DB" <<EOF
INSERT INTO GAMES
(name,					slug, 		platform,	runner,	directory,	lastplayed,	installed,	installed_at,		configpath,		has_custom_banner,	has_custom_icon,	has_custom_coverart_big,	playtime,	sortname)
VALUES
('$TRANSLATED_NAME',	'$SLUG', 	'Windows',	'wine',	'',			0,			1,			'$INSTALLED_AT',	'$CONFIG_PATH',	0,					0,					0,							0,			'')
EOF
