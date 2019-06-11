#!groovy​

pipeline {
	agent any

    options {
        skipStagesAfterUnstable()
    }

	environment {
		GOARCH = 'amd64'
  		PRODUCT_NAME = 'codewind-installer'
	}

	stages {
		stage ('preInstall') {
			// Use golang.
			agent { docker { image 'golang:1.12.5' } }

			steps {
				script {
					sh 'echo "starting preInstall.....: GOPATH=$GOPATH"'
					sh 'pwd' 
					sh 'echo $PATH'
					sh 'whoami'
					// test some env variable set by Jenkins
					sh 'echo JENKINS_HOME=$JENKINS_HOME'
					// PWD is the current directory.
					sh '''
						codeDirectory=$PWD
						echo "codeDirectory=$codeDirectory"
						projectDir=$(basename $PWD)
						echo "project directory is $projectDir"
						cd ..
						which go
						go version
						export GOPATH=$GOPATH:$(pwd)
						echo "set GOPATH=$GOPATH"
						go version
						mkdir -p src
						if [ -d "src/$projectDir" ]; then 
							echo "remove existing $projectDir directory from go src path"
							rm -rf src/$projectDir
						fi	
						cp -r $projectDir src
						cd src/$projectDir
						echo "code copied to $(pwd) for go compile."
						go version
						which go
						curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
						dep ensure -v
						'''
				}
			}
		}
		stage ('install') {
			// Use golang.
			steps {
				script {
					sh 'echo "starting install....."'
					sh 'echo $PATH'
					// sh 'dep ensure -v'
				}
			}
		}

		stage('Build') {

			// Use golang.
			agent { docker { image 'golang:1.12.5' } }

			steps {
				script {
					sh 'echo "Starting build for ${PRODUCT_NAME}..."'
					sh '''
						export GPATH=$PWD
						echo "Building in directory $(pwd)"
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
                echo 'Testing'
            }
        }
        
        stage('Upload') {
            steps {
            	script {
	                echo 'Uploading to dockerhub...'	                
                }
            }
        }
	}
	
	post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
			sh '''
				# mkdir ${product_name}
  				# mv -v ${product_name}-* ${product_name}/
  				# artifact_name tells deploy.sh what file to upload
  				export artifact_name="${product_name}.zip"
  				# zip -r $artifact_name ${product_name}
  				# travis-scripts/deploy.sh
			'''	  
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}