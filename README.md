### msi-factory

### Description
This pipeline uses a windowsservercore docker container to input the WiX XML and powershell script for execution.

Toolset
WiX
Powershell
Docker

### Configuration
The directory must be setup with the following structure.

C:\WIX-PROJECT
└───pkg
    ├───output
    ├───[PACKAGE]
    └───stage

Files to be installed are in [PACKAGE]

any predefined WiX XML objects are to be in ```stage```

The docker container can be built with ```docker build msi-factory .``` when in the current working directory contains the ```Dockerfile```


### How it Works

Run the following docker command:

```docker run –it –v ${PWD}:/pkg:c:/pkg msi-factory powershell –c “c:\pkg\msi-build.ps1”```

The script ```msi-build.ps1``` will scan the directory [PACKAGE] and create a directory.wxs fragment. It will then right candle and light to create the ```.wixobj``` files and subsequently the final MSI package. The final file will be output to ```output```
