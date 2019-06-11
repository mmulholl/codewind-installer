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
    image: golang:1.11-alpine3.9
    tty: true
    command:
    - cat
"""
    	}

	}
//	agent  {
//		docker { image 'golang:1.12.5' }
//	}

//   	tools {
//		   go 'go1.12.5'
//	}

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
				script {
					sh 'echo "starting preInstall.....: GOPATH=$GOPATH"'
					sh '''
						# add the base directory to the gopath
						DEFAULT_CODE_DIRECTORY=$PWD
						cd ../..
						export GOPATH=$GOPATH:$(pwd)
						if [ -d $CODE_DIRECTORY_FOR_GO ]; then
							rm -rf $CODE_DIRECTORY_FOR_GO
						fi
						mkdir -p $CODE_DIRECTORY_FOR_GO
						cd $CODE_DIRECTORY_FOR_GO
						cp -r $DEFAULT_CODE_DIRECTORY/* .	
						echo $DEFAULT_CODE_DIRECTORY >> $DEFAULT_WORKSPACE_DIR_FILE
						# get all of of the go dependences
						curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
						dep ensure -v
						echo "Building in directory $(pwd)"
						'''
				}
			}
		}

		stage('Build') {

			steps {
				script {
					sh '''
						# add the base directory to the gopath
						cd ../..
						export GOPATH=$GOPATH:$(pwd)
						cd $CODE_DIRECTORY_FOR_GO
						GOOS=darwin go build -o ${PRODUCT_NAME}-macos
  						GOOS=windows go build -o ${PRODUCT_NAME}-win.exe
  						GOOS=linux go build -o ${PRODUCT_NAME}-linux
  						chmod -v +x ${PRODUCT_NAME}-*
					'''

		    	}
			}
		}
		
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