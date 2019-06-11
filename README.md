# Codewind Installer
Install Codewind on MacOS or Windows.
Prebuilt binaries are available for download [on Artifactory](https://sys-mcs-docker-local.artifactory.swg-devops.com/artifactory/sys-mcs-docker-local/codewind-installer/).

[![Build Status](https://travis.ibm.com/dev-ex/codewind-installer.svg?token=jLZpzPrJozeLHsb1tpsR&branch=master)](https://travis.ibm.com/dev-ex/codewind-installer)
[![Eclipse License](https://img.shields.io/badge/license-Eclipse-brightgreen.svg)](https://github.ibm.com/dev-ex/tempest/blob/master/LICENSE)

## Downloading the release binary for MacOS
1. Download the release binary file to a folder on your system.
2. Use the `cd` command to go to the location of the downloaded file in the Terminal window.
3. If the binary file has the extension `.dms`, remove the extension so that the file is named `mac-installer`.
4. Enter the `chmod 775 installer` command to give yourself access rights to run the binary file on your system. 
5. Export the environment variables for artifactory authentication with the following commands:
```
$ export USER=<artifactory-username>
$ export PASS=<artifactory-API-key>
```
6. If you already have a `microclimate-workspace` with your projects in it, copy it into your `/Users/<username>` home directory. If you do not already have a workspace, the installer creates an empty workspace for you in this directory.
7. Type `./mac-installer` in the Terminal window with the exported environment variables to run the installer.
8. To run a command, enter `./mac-installer <command>`.

## Downloading the release binary for Windows
1. Download the release binary file to a folder on your system.
2. Use the `cd` command to go to the location of the downloaded file in the command prompt.
3. Ensure that the binary file has an `.exe` extension. If it doesn't, add the extension to the file name.
4. Export the environment variables for artifactory authentication with the following commands:
```
> $ENV:USER += <artifactory-username>
> $ENV:PASS += <artifactory-API-key>
```
5. If you already have a `microclimate-workspace` with your projects in it, copy it into your `C:\` directory. If you do not already have a workspace, the installer creates an empty one for you in this directory.
6. To get started and see the commands available, type the ` .\win-installer.exe` command in the command prompt with the exported environment variables.
7. To run a command, enter ` .\win-installer.exe <command>`.

## Build and deploying locally on MacOS
1. Ensure that you have a Go environment set up. If you don't yet have a Go environment, see [Install Go for NATS](https://nats.io/documentation/tutorials/go-install/).
2. If you have Brew, use the following commands to install `dep` for MacOS:
```
$ brew install dep
$ brew upgrade dep
```
3. Clone the `git clone git@github.ibm.com:dev-ex/codewind-installer.git` repo.
4. Use the `cd` command to go into the project directory and install the vendor packages with the `dep ensure -v` command.
5. Build the binary and give it a name with the `go build -o <binary-name>` command.
6. Export the environment variables for artifactory authentication with the following commands:
```
$ export USER=<artifactory-username>
$ export PASS=<artifactory-API-key>
```
7. Copy your Microclimate workspace into your `/Users/<username>` home directory.
8. Type `./<binary-name>` in the Terminal window with the exported environment varibles to run the installer.
9. To run a command, enter `./<binary-name> <command>`.

## Creating a cross-platform binary
1. Use the `go tool dist list` command to get a list of the possible `GOOS/ARCH` combinations available to build.
2. Choose the `GOOS/ARCH` that you want to build for and then enter `GOOS=<OS> GOARCH=<ARCH> go build` to create the binary.

## Unit testing
1. Clone this repository.
2. `cd` into the test directory. `utils.go` tests are located `utils/utils_test.go`.
3. To run all of the tests, in the Terminal window type the command `go test -v` and wait for them to finish.
4. For any other unit tests, the same applies but the directory may change.

 ## Installing for Codewind on Kubernetes

See [Installing Eclipse Che on Kubernetes](https://github.ibm.com/dev-ex/che-docs/wiki/Installing-Eclipse-Che-on-Kubernetes) for instructions on installing.

## Contributing
Submit issues and contributions:
1. [Submitting issues](https://github.com/eclipse/codewind/issues)
2. [Contributing](CONTRIBUTING.md)

## License
See the following link for license information:
[EPL 2.0](https://www.eclipse.org/legal/epl-2.0/)
