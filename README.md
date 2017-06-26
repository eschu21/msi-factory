### MSI-Factory

### Description
This pipeline uses a windowsservercore docker container to input the WiX XML and powershell script for execution. The expected output is an MSI installer for the target application.

### Toolset
WiX
Powershell
Docker

### Configuration
The directory must be setup with the following structure.

    C:\
    └───pkg
        ├───output
        ├───[PACKAGE]
        └───stage

Application source files to be installed are in [PACKAGE]

Any predefined WiX XML objects are to be in ```C:\pkg\stage```

The docker container can be built with the command: ```docker build msi-factory .``` when in the current working directory contains the ```Dockerfile```.


### How it Works

Run the following docker command:

```docker run –t –v ${PWD}:/pkg:c:/pkg msi-factory powershell “c:\pkg\msi-build.ps1”```

OR

Run the following script within the directory c:\pkg: ```docker-msi-start.ps1```

The script ```msi-build.ps1``` will scan the directory [PACKAGE] and create a directory.wxs fragment. It will then run candle.exe and light.exe to create the ```.wixobj``` files and subsequently the final MSI package. The final file will be output to ```output```, and the permissions on all files within the ```output``` directory will be set to Full-Control for group Administrators.
