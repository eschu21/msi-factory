## Powershell Script to Create MSI ##

## Variables ##

# WIX Source Dir #
$WIX_DIR="C:\Program Files (x86)\WiX Toolset v3.11\bin"

# Source Dir for files to be enumerated into MSI #
$SRC_DIR="C:\filebeat-5.4.1-windows-x86_64"


# Name of our Application #
$APP_NAME="Filebeat"

# Where to stage the various .wxs files #
$STG_DIR="C:\wix-project\${APP_NAME}\stage"

# Where to deliver the Final Product #
$TGT_DIR="C:\wix-project\${APP_NAME}\output"

## Create MSI ##

# Compile the source files into a Fragment to be referenced by main builder Product.wxs #
& ${WIX_DIR}\heat.exe dir $SRC_DIR -srd -dr INSTALLDIR -cg MainComponentGroup -out ${STG_DIR}\directory.wxs -ke -sfrag -gg -suid -var var.SourceDir -sreg -scom

# Convert the .wxs files into .wxobj for consumption by light.exe #
& ${WIX_DIR}\candle.exe -dSourceDir="${SRC_DIR}" ${STG_DIR}\*.wxs -o ${STG_DIR}\ -ext WixUtilExtension -arch x64

# Create the final MSI package --CURRENTLY REFERENCING THE FILES EXPLICITY. NEED TO FIND WAY TO WILDCARD! #
& ${WIX_DIR}\light.exe -o ${TGT_DIR}\${APP_NAME}_installer.msi ${STG_DIR}\customaction.wixobj ${STG_DIR}\directory.wixobj ${STG_DIR}\product.wixobj -cultures:en-US -ext WixUIExtension.dll -ext WiXUtilExtension.dll
