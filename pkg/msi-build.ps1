## Powershell Script to Create MSI ##

## Variables ##

# Source Dir for files to be enumerated into MSI #
$SRC_DIR="c:\pkg\filebeat"

# Name of our Application #
$APP_NAME="Filebeat"

# Where to stage the various .wxs files #
$STG_DIR="c:\pkg\stage"

# Where to deliver the Final Product #
$TGT_DIR="c:\pkg\output"


## Create MSI ##

# Compile the source files into a Fragment to be referenced by main builder Product.wxs #
& heat.exe dir $SRC_DIR -srd -dr INSTALLDIR -cg MainComponentGroup -out ${STG_DIR}\directory.wxs -ke -sfrag -gg -suid -var var.SourceDir -sreg -scom

# Convert the .wxs files into .wxobj for consumption by light.exe #
& candle.exe -dSourceDir="${SRC_DIR}" ${STG_DIR}\*.wxs -o ${STG_DIR}\ -ext WixUtilExtension -arch x64

# Create the final MSI package --CURRENTLY REFERENCING THE FILES EXPLICITY. NEED TO FIND WAY TO WILDCARD! #
& light.exe -o ${TGT_DIR}\${APP_NAME}_installer.msi ${STG_DIR}\customaction.wixobj ${STG_DIR}\directory.wixobj ${STG_DIR}\product.wixobj -cultures:en-US -ext WixUIExtension.dll -ext WiXUtilExtension.dll
