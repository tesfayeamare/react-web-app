pipeline {
  agent any
  environment {
    acr_registryName = "hexxo"
    acr_registryUrl = "hexxo.azurecr.io"
    registryCredential = "ACR"
    dockerImage = ''
  }
  stages {
    stage('checkout') {
        steps {
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'jenkins-pat', url: 'https://github.com/tesfayeamare/react-web-app.git']])
        }
    }
    stage('Building Docker Image') {
        steps {
            script {
                dockerImage = docker.build acr_registryName
            }
        }
    }
    stage('Upload Image to ACR') {
        steps {
            script {
                docker.withRegistry( "http://${acr_registryUrl}", registryCredential ) {
                    dockerImage.push()
                }
            }
        }
    }
  }
}