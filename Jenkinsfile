#!groovy​

pipeline {

	agent {
		kubernetes {
      		label 'go-pod'
			yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: go
    image: golang:1.11-stretch
    tty: true
    command:
    - cat
"""
    	}
	}

	tools {
		git 'git'
	} 

    options {
        skipStagesAfterUnstable()
    }

	environment {
  		PRODUCT_NAME = 'codewind-installer'
		CODE_DIRECTORY_FOR_GO = 'src/codewind-installer'
		DEFAULT_WORKSPACE_DIR_FILE = 'temp_default_dir'
	}

	stages {
		
		stage ('preBuild') {
			steps {
				container('go') {
					sh 'echo "starting preInstall.....: GOPATH=$GOPATH"'
					sh '''
						# add the base directory to the gopath
						DEFAULT_CODE_DIRECTORY=$PWD
						cd ../..
						export GOPATH=$GOPATH:$(pwd)
						# create a new directory to store the code for go compile 
						if [ -d $CODE_DIRECTORY_FOR_GO ]; then
							rm -rf $CODE_DIRECTORY_FOR_GO
						fi
						mkdir -p $CODE_DIRECTORY_FOR_GO
						cd $CODE_DIRECTORY_FOR_GO
						# copy the code into the new directory for go compile
						cp -r $DEFAULT_CODE_DIRECTORY/* .	
						echo $DEFAULT_CODE_DIRECTORY >> $DEFAULT_WORKSPACE_DIR_FILE
						
						ls -la
						
						set

						# get dep and run it
						wget -O - https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
						dep status
						dep ensure -v

						# now compile the code
						export HOME=$JENKINS_HOME
						export GOCACHE="off"
						export GOARCH=amd64
						GOOS=darwin go build -o ${PRODUCT_NAME}-macos
  						GOOS=windows go build -o ${PRODUCT_NAME}-win.exe
  						GOOS=linux go build -o ${PRODUCT_NAME}-linux
  						chmod -v +x ${PRODUCT_NAME}-*

					'''
				}
			}
		}

//		stage('Build') {
//			steps {
//				container('go') {
//					sh '''
//						# add the base directory to the gopath
//						cd ../..
//						export GOPATH=$GOPATH:$(pwd)
//						echo "HOME=$HOME"
//						echo "JENKINS_HOME=$JENKINS_HOME"
//						export HOME=$JENKINS_HOME
//						echo "GOCACHE=$GOCACHE"
//						go env GOCACHE
//						export GOCACHE="off"
//						go env GOCACHE
//						cd $CODE_DIRECTORY_FOR_GO
//						GOOS=darwin go build -o ${PRODUCT_NAME}-macos
//						GOOS=windows go build -o ${PRODUCT_NAME}-win.exe
//  					GOOS=linux go build -o ${PRODUCT_NAME}-linux
//  					chmod -v +x ${PRODUCT_NAME}-*
//					'''
//				}
//			}
//		}
		
		stage('Test') {
            steps {
                echo 'Testing to be defined.'
            }
        }
        
        stage('Upload') {
          steps {
				script {
					sh '''
						cd ../../$CODE_DIRECTORY_FOR_GO
						echo $(pwd)
						if [ -d $PRODUCT_NAME ]; then
							rm -rf $PRODUCT_NAME
						fi	
						mkdir $PRODUCT_NAME
						
						# WINDOWS EXE: Submit Windows unsigned.exe and save signed output to signed.exe
                        # curl -o $PRODUCT_NAME/${PRODUCT_NAME}-win-signed.exe  -F file=@${PRODUCT_NAME}-win.exe http://build.eclipse.org:31338/winsign.php

  						mv -v $PRODUCT_NAME-* $PRODUCT_NAME/
						DEFAULT_WORKSPACE_DIR=$(cat $DEFAULT_WORKSPACE_DIR_FILE)
						cp -r $PRODUCT_NAME $DEFAULT_WORKSPACE_DIR 
						echo "zip up the images - does not work!"  
					'''

					//zip archive: true,  dir: 'codewind-installer', glob: ' ', zipFile: 'codewind-installer.zip'
                    //archiveArtifacts artifacts: 'codewind-installer.zip', fingerprint: true
				}		 
			}
        }
	}
	
	post {
        success {
			echo 'Build SUCCESS'
        }
    }
}
