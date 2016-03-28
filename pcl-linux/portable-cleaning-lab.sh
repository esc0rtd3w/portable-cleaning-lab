#!/bin/sh

# PCL Linux v0.0.1

# esc0rtd3w / Portable Cleaning Lab 2015

# esc0rtd3w@gmail.com



initMain(){

setTerminal
resizeWindow
setWindowTitle
setPermissions
setDependencies
checkDependencies
setDefaults

menuMain

}


setPermissions(){

blank=""

}


setDependencies(){

pathDependencyFile1="/usr/bin/DependencyFile1"

}


checkDependencies(){

if [ -f $pathDependencyFile1 ];
then
   statusDependencyFile1="OK"
else
   statusDependencyFile1="NA"
fi

}


downloadDependencies(){

blank=""

}


showDependencies(){

banner
navBar

echo ""
echo "List of File Dependencies Needed"
echo ""
echo "$pathDependencyFile1 - Status: $statusDependencyFile1"
echo ""
echo ""

echo "Press ENTER to continue...."

read pause

}


setDefaults(){

baseVersion="0.0.1"
tempDirectory=""
runDirectory="$PWD"

count="0"
padding=""


# Windows Partition Mount Points
partWinA="/media/pcl/windows/a"
partWinB="/media/pcl/windows/b"
partWinC="/media/pcl/windows/c"
partWinD="/media/pcl/windows/d"
partWinE="/media/pcl/windows/e"
partWinF="/media/pcl/windows/f"
partWinG="/media/pcl/windows/g"
partWinH="/media/pcl/windows/h"
partWinI="/media/pcl/windows/i"
partWinJ="/media/pcl/windows/j"
partWinK="/media/pcl/windows/k"
partWinL="/media/pcl/windows/l"
partWinM="/media/pcl/windows/m"
partWinN="/media/pcl/windows/n"
partWinO="/media/pcl/windows/o"
partWinP="/media/pcl/windows/p"
partWinQ="/media/pcl/windows/q"
partWinR="/media/pcl/windows/r"
partWinS="/media/pcl/windows/s"
partWinT="/media/pcl/windows/t"
partWinU="/media/pcl/windows/u"
partWinV="/media/pcl/windows/v"
partWinW="/media/pcl/windows/w"
partWinX="/media/pcl/windows/x"
partWinY="/media/pcl/windows/y"
partWinZ="/media/pcl/windows/z"


# Mac Partition Mount Points
partMacA="/media/pcl/mac/a"
partMacB="/media/pcl/mac/b"
partMacC="/media/pcl/mac/c"
partMacD="/media/pcl/mac/d"
partMacE="/media/pcl/mac/e"
partMacF="/media/pcl/mac/f"
partMacG="/media/pcl/mac/g"
partMacH="/media/pcl/mac/h"
partMacI="/media/pcl/mac/i"
partMacJ="/media/pcl/mac/j"
partMacK="/media/pcl/mac/k"
partMacL="/media/pcl/mac/l"
partMacM="/media/pcl/mac/m"
partMacN="/media/pcl/mac/n"
partMacO="/media/pcl/mac/o"
partMacP="/media/pcl/mac/p"
partMacQ="/media/pcl/mac/q"
partMacR="/media/pcl/mac/r"
partMacS="/media/pcl/mac/s"
partMacT="/media/pcl/mac/t"
partMacU="/media/pcl/mac/u"
partMacV="/media/pcl/mac/v"
partMacW="/media/pcl/mac/w"
partMacX="/media/pcl/mac/x"
partMacY="/media/pcl/mac/y"
partMacZ="/media/pcl/mac/z"


# Default input and output for /dev/*


# Find Filesystems
findNTFS=$(fdisk -l | grep NTFS | cut -c-10)
findFAT=$(fdisk -l | grep FAT | cut -c-10)
findFAT16=$(fdisk -l | grep FAT16 | cut -c-10)
findFAT32=$(fdisk -l | grep FAT32 | cut -c-10)
findHFS=$(fdisk -l | grep HFS | cut -c-10)
findEXT=$(fdisk -l | grep Linux | cut -c-10)
findSWAP=$(fdisk -l | grep swap | cut -c-10)

# Mount Partition
fs="ntfs"
partition=""
mountPoint="$partWinA"
mountNTFS=$(mount -t ntfs -o nls=utf8,umask=0222 /dev/sdx /media/pcl/win/c)
mountFAT=$(mount -t vfat -o iocharset=utf8,umask=000 /dev/sdx /media/pcl/win/c)

# HFS / HFS+
#apt-get install hfsprogs
mountHFS=$(mount -t hfsplus -o force,rw /dev/sdx /media/pcl/mac/a)
mountHFS_alt=$(mount -t hfsplus -o remount,force,rw /dev/sdx /media/pcl/mac/a)
mountHFS_fix=$(fsck.hfsplus /dev/sdx)


}


getPCLRoot(){

pclRoot="$PWD"

}


resizeWindow(){

# From sample: printf '\033[8;32;114t'
# Change WIDTH (W) ([8;WW)
# Change HEIGHT (H) (;HHHt')

printf '\033[8;29;89t'

}


setWindowTitle(){

title='echo -ne "\033]0;Portable Cleaning Lab / PCL Linux v0.0.1 / portablecleaninglab.com\007"'

$title

}


setTerminal(){

terminal="gnome-terminal -x"
#terminal="konsole -e"
#terminal="xterm -e"

}

banner(){

clear
#echo "Portable Cleaning Lab / PCL Linux v$baseVersion"
#echo ""

}


navBar(){

echo "-----------------------------------------------------------------------------------------"
#echo "[OS: $ostype/$bits] [Safe Mode: $safeModeState] [Network: $networkStatus] [Mode: $uiMode]"
echo "[OS: Linux/x86] [Safe Mode: Not Applicable] [Network: Online] [Mode: Expert]"
echo "-----------------------------------------------------------------------------------------"
echo ""

}


bannerExit(){

clear
echo "Portable Cleaning Lab"
echo ""
echo "PCL Linux v$baseVersion"
echo ""
echo "portablecleaninglab.com"
echo ""
echo ""

}


tempFolderCreate(){

#mkdir "$tempDirectory"
#mkdir "$runDirectory"
blank=""

}


tempFolderDestroy(){

#rm "$tempDirectory"
#rm "$runDirectory"
blank=""

}


addPadding(){

if (($count > 9999)); then

padding=""

fi

if (($count > 999)); then

padding=""

fi

if (($count > 99)); then

padding="0"

fi

if (($count < 10)); then

padding="000"

fi

if (($count > 9)); then

padding="00"

fi

if (($count > 99)); then

padding="0"

fi

if (($count > 999)); then

padding=""

fi

if (($count > 9999)); then

padding=""

fi

}


menuMain(){

banner
navBar
getPCLRoot

echo "Choose an Operating Mode and press ENTER:"
echo ""
echo ""
echo ""
echo "1) Clean A Windows Partition"
echo ""
echo "2) Clean A Linux Partition"
echo ""
echo "3) Clean A Mac OS X Partition"
echo ""
echo ""
echo ""
echo ""
echo "X) Exit This Window"
echo ""
echo ""

read getVariable

case "$getVariable" in

"")
menuMain
;;

"M" | "m")
menuMain
;;

"X" | "x")
bannerExit
exit
;;

"1")
banner
navBar
echo "WINDOWS MODE"
echo ""
echo "Select a partition from below and press ENTER:"
echo ""
echo ""

case "$findNTFS" in

"")
echo "No Windows NTFS Partitions Found!"
echo ""
read pause
echo ""
# DO STUFF HERE
menuMain
;;

*)
echo "$findNTFS"
echo ""
read pause
echo ""
# DO STUFF HERE
menuMain
;;

esac
;;


"2")
banner
navBar
echo "LINUX MODE"
echo ""
echo "Select a partition from below and press ENTER:"
echo ""
echo ""

case "$findEXT" in

"")
echo "No Linux EXT Partitions Found!"
echo ""
read pause
echo ""
# DO STUFF HERE
menuMain
;;

*)
echo "$findEXT"
echo ""
read pause
echo ""
# DO STUFF HERE
menuMain
;;

esac

;;


"3")
banner
navBar
echo "MAC MODE"
echo ""
echo "Select a partition from below and press ENTER:"
echo ""
echo ""

case "$findHFS" in

"")
echo "No Mac HFS Partitions Found!"
echo ""
read pause
echo ""
# DO STUFF HERE
menuMain
;;

*)
echo "$findHFS"
echo ""
read pause
echo ""
# DO STUFF HERE
menuMain
;;

esac

;;

"4")
echo "Option 4"
echo ""
echo "Press ENTER to continue..."
echo ""
echo ""
read pause
# DO STUFF HERE
menuMain
;;

"5")
echo "Option 5"
echo ""
echo "Press ENTER to continue..."
echo ""
echo ""
read pause
# DO STUFF HERE
menuMain
;;

"6")
echo "Option 6"
echo ""
echo "Press ENTER to continue..."
echo ""
echo ""
read pause
# DO STUFF HERE
menuMain
;;

*)
menuMain
;;

esac

menuMain

}



initMain


