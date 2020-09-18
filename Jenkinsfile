pipeline {
    agent any
    environment {
        SG_CLIENT_ID = credentials("SG_CLIENT_ID")
        SG_SECRET_KEY = credentials("SG_SECRET_KEY")
        CHKP_CLOUDGUARD_ID = credentials("CHKP_CLOUDGUARD_ID")
        CHKP_CLOUDGUARD_SECRET = credentials("CHKP_CLOUDGUARD_SECRET")
    }

    stages {
        stage('Clone Github repository') {
            steps {
                checkout scm
            }
        }
        
        stage('SourceGuard Code Scan') {   
            steps {   
                script {      
                    try {
                        sh 'echo stub'
                        // sh '/usr/local/bin/shiftleft sourceguard -src .'
                    } catch (Exception e) {
                        echo "Code Analysis is BLOCK and recommend not using the source code"  
                    }
                }
            }
        }
           
        stage('Docker image Build and scan prep') {
            steps {
                sh 'docker build -t asrud/sg .'
                sh 'docker save asrud/sg -o sg.tar'
            } 
        }

        stage('SourceGuard Image Scan') {   
            steps {   
                script {      
                    try {
                        sh 'echo stub'
                        // sh './sourceguard-cli -img sg.tar'
                    } catch (Exception e) {
                        echo "Image Analysis is BLOCK and recommend not using the source code"  
                    }
                }
            }
        }
           
        stage('Docker image upload') {
            steps {
                sh 'docker push asrud/sg:latest'
            } 
        }

        stage('Deploy to Azure Web App') {
            steps {
                azureWebAppPublish azureCredentialsId: 'azure-cli-2020-09-17-15-02-29', publishType: 'docker',
                   resourceGroup: 'rgFunc', 
                   appName: 'nojes-cont',
                   dockerImageName: 'asrud/sg', dockerImageTag: 'latest',
                   dockerRegistryEndpoint: [credentialsId: 'DockerHub', url: '']
            } 
        }

    }            
}
