 #!/usr/bin/env bash

set -euo pipefail
# set -x


# ---- INIT ---------------------------------------------------------- #
# directory contaning directories of games
CWP="$PWD"

# tools/ is one level above the script
DIRTOOLS=$(realpath `dirname "$0"`/../tools) 

# create dist directory for .love, .exe .AppImage
mkdir -p dist

# remove the possible trailing '/'
NAME=$(echo $1 | sed -e 's#/$##')


# ---- .LOVE --------------------------------------------------------- #
function make_dot_love(){
    local gameLove=$NAME.love
    cd $NAME
    zip -q -9 -r $gameLove *
    mv $gameLove ../dist/.
    cd ..    
}


# ---- .EXE (32,64bits) ------------------------------------------------ #
function make_dot_exe(){
    local gameLove=$NAME.love
    local gameWin=${NAME}_win${1}b

    cd $DIRTOOLS

    unzip -q -o -j "love$1.zip" -d $gameWin


    cat "$gameWin/love.exe" "$CWP/dist/$gameLove" > "$gameWin/$gameWin.exe"
    rm -rf "$gameWin/love.exe"
    cd $gameWin
    zip -q -9 -r "$gameWin.zip" *
    mv "$gameWin.zip" $CWP/dist/.
    cd ..
    rm -rf $gameWin
}


# ---- .APPIMAGE ----------------------------------------------------- #
function make_dot_appimg(){

    local gameLove=$NAME.love

    local sqfsLove='squashfs-root/bin/love'
    local sqfsGame='squashfs-root/bin/SuperGame'

    cd $DIRTOOLS

    ./love2d --appimage-extract

    cat "$sqfsLove" "$CWP/dist/$gameLove" > "$sqfsGame"
    mv "$sqfsGame" "$sqfsLove"
    chmod +x "$sqfsLove"

    #sed -i "s/Exec=love %f/Exec=$NAME \%f/g" 'sqfsr/love.desktop'

    ./appimgtool 'squashfs-root' "$CWP/dist/$NAME.AppImage"

    rm -rf 'squashfs-root'
}


# ---- DIALOG GUI ---------------------------------------------------- #
TARGETS=$(dialog --stdout --checklist  "Mark for deploy" 0 0 0 \
    'Love2D'   "love-XX.Y.AppImage"         'on'  \
    'Win32'    "Windows 32-bits executable" 'off' \
    'Win64'    "Windows 64-bits executable" 'off'  \
    'AppImage' "with AppImageKit"           'on'  \
)

clear

# ---- ACTIONS ------------------------------------------------------- #
for target in $TARGETS; do
    case $target in
          'Love2D') make_dot_love   ;;
           'Win32') make_dot_exe 32 ;;
           'Win64') make_dot_exe 64 ;;
        'AppImage') make_dot_appimg ;;
    esac
done