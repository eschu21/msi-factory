#!/bin/bash

# if [ -d "/pkg" ]; then
#   build_root=/pkg
# else
#   echo "Please set you build directory"
#   exit 1
# fi

if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  exit 1
fi

main() {
  buildWixObject() {
    su -p -l wine -c "wine candle.exe $1"
    if [ $? -ne 0 ]; then
      echo "ERROR: Issue building the wixobj file"
      junk=`ls -1 *.wixobj 2>/dev/null | wc -l`
      if [ $junk != 0 ]; then
        rm -f *.wixobj
      fi
      exit 1
    fi
  }

  buildMsi() {
    su -p -l wine -c "wine light.exe -sval *.wixobj"
    if [ $? != 0 ]; then
      echo "ERROR: Issue building the MSI"
      junk=`ls -1 *.wixobj 2>/dev/null | wc -l`
      if [ $junk != 0 ]; then
        rm -f *.wixobj
      fi
      exit 1
    fi
  }

buildWixObject $1
buildMsi
}

main $1
