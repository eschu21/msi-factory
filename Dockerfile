# Sample Dockerfile

# Indicates that the windowsservercore image will be used as the base image.
FROM microsoft/windowsservercore

# Metadata indicating an image maintainer.
MAINTAINER jshelton@contoso.com

SHELL ["powershell","-command"]

# Create Temp Directory for WiX package-builder
RUN ["powershell","New-Item","c:\\wix -type Directory"]

# Create target directory for payloads
RUN ["powershell","New-Item","c:\\pkg -type Directory"]

# Set to Powershell execution policy
RUN ["powershell","Set-ExecutionPolicy Unrestricted"]

# Pull WiX Toolset
RUN ["powershell","Start-BitsTransfer", "-Source http://wixtoolset.org/downloads/v3.11.0.1528/wix311-binaries.zip","-Destination C:\\wix\\"]

# Unzip that shit
RUN ["powershell","Expand-Archive C:\\wix\\wix311-binaries.zip c:\\wix"]

# Add WiX bin directory to environment
#RUN ["powershell","$oldpath = (Get-ItemProperty -Path `Registry::HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Session Manager\\Environment' -Name PATH).path ; $newpath = "$oldpath;c:\\wix\\bin" ;  Set-ItemProperty -Path `Registry::HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Session Manager\\Environment' -Name PATH -Value $newPath]

# Set Path
#["powershell","[Environment]::SetEnvironmentVariable( "Path", $env:Path + ";c:\\wix", [System.EnvironmentVariableTarget]::Machine )"]
RUN "[Environment]::SetEnvironmentVariable( \"Path\" ,$env:Path+ \";c:\\wix\", [System.EnvironmentVariableTarget]::Machine )"

# Sets a command or process that will run each time a container is run from the new image.
#CMD [ "cmd" ]
