#!/bin/bash


PWD=$(pwd)

codeDirectory=$PWD
echo "codeDirectory=$codeDirectory"
projectDir=$(basename $PWD)
echo "project directory is $projectDir"
cd ..
export GOPATH=$(pwd)
echo "set GOPATH=$GOPATH"
mkdir -p src
if [ -d "src/$projectDir" ]; then 
    echo "remove existing $projectDir directory from go src path"
	rm -rf src/$projectDir
fi	
cp -r $projectDir src
cd src/$projectDir
echo "code copied to $(pwd) for go compile."
