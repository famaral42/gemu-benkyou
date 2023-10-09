#!/usr/bin/env bash

set -euo pipefail
# set -x


# ---- INIT ---------------------------------------------------------- #
CWP="$PWD"

DIR=$(realpath `dirname "$0"`/../tools) # one level above

mkdir -p $DIR


# ---- GENERIC DOWNLOAD ---------------------------------------------- #
function download_generic(){

    local url="$1"
    local file="$2"
    local executable=true

    cd $DIR

    if [ -f $file ]; then
        printf "%-25s" "$file"
        echo "already exists!"
    else
        wget \
            --no-check-certificate \
            --timeout=5 \
            --tries=3 \
            --quiet \
            --show-progress \
            $url -O $file
        
        if $executable; then
            chmod +x $file
        fi
    fi

    cd $CWP
}


# ---- APP IMAGE TOOL ------------------------------------------------ #
function download_appimgtool(){

    local version="13"

    local file="appimgtool"

    local url="https://github.com/AppImage/AppImageKit/releases/download/${version}/appimagetool-x86_64.AppImage"

    download_generic $url $file
}

# ---- LOVE 2D STUFF ------------------------------------------------- #
function download_love2d_stuff(){

    local version="11.4"

    local url_base="https://github.com/love2d/love/releases/download/$version"
    local url_file=$url_base/love-$version
    local file=""
    local executable=false

    case $1 in
        'Love2D')
            url_file=${url_file}-x86_64.AppImage
            file='love2d'
            executable=true
            ;;
        'Win32')
            url_file=${url_file}-win32.zip;
            file='love32.zip'
            executable=false
            ;;
        'Win64')
            url_file=${url_file}-win64.zip;
            file='love64.zip'
            executable=false
            ;;
    esac

    download_generic $url_file $file $executable
}



# ---- DIALOG GUI ---------------------------------------------------- #
TARGETS=$(dialog --stdout --checklist  "Mark for download" 0 0 0 \
    'Love2D'       "love-XX.Y.AppImage"         'on'  \
    'Win32'        "Windows 32-bits executable" 'off' \
    'Win64'        "Windows 64-bits executable" 'on'  \
    'AppImageTool' "from AppImageKit"           'on'  \
)


clear



# ---- ACTIONS ------------------------------------------------------- #
for target in $TARGETS; do
    case $target in
        'Love2D')
            download_love2d_stuff 'Love2D'
            ;;
        'Win32')
            download_love2d_stuff 'Win32'
            ;;
        'Win64')
            download_love2d_stuff 'Win64'
            ;;
        'AppImageTool')
            download_appimgtool
            ;;
    esac
done

