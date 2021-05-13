#!/usr/bin/env bash

cyan="\033[0;36m"
endColor="\033[0m"

# Note: realpath requires `coreutils` to be installed:
# brew install coreutils
currentFile=$(realpath ${0})
currentDir=$(dirname ${currentFile})
parentDir=$(dirname ${currentDir})
pushd ${parentDir}

version=$(dart "./scripts/get_version.dart")

echo -e "${cyan}Cleaning...${endColor}"

flutter clean

echo -e "${cyan}Building a new iOS release for version ${version}...${endColor}"

flutter build ipa --dart-define=isProduction=true --dart-define=release=${version}

echo -e "${cyan}Building a new Android release for version ${version}...${endColor}"

flutter build appbundle --dart-define=isProduction=true --dart-define=release=${version}

popd
