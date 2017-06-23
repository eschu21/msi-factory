## 

# Indicates that the windowsservercore image will be used as the base image.
FROM microsoft/windowsservercore

# Metadata indicating an image maintainer.
MAINTAINER jshelton@contoso.com

SHELL ["powershell","-command"]

# Create Temp Directory for WiX package-builder
RUN ["powershell","New-Item","c:\\wix -type Directory"]

# Create target directory for payloads
RUN ["powershell","New-Item","c:\\pkg -type Directory"]

# Pull WiX Toolset
RUN ["powershell","Start-BitsTransfer", "-Source http://wixtoolset.org/downloads/v3.11.0.1528/wix311-binaries.zip","-Destination C:\\wix\\"]

# Unzip the WiX binaries
RUN ["powershell","Expand-Archive C:\\wix\\wix311-binaries.zip c:\\wix"]

# Set Path
#["powershell","[Environment]::SetEnvironmentVariable( "Path", $env:Path + ";c:\\wix", [System.EnvironmentVariableTarget]::Machine )"]
RUN "[Environment]::SetEnvironmentVariable( \"Path\" ,$env:Path+ \";c:\\wix\", [System.EnvironmentVariableTarget]::Machine )"

# Sets a command or process that will run each time a container is run from the new image.
#CMD [ "cmd" ]
