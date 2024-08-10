pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/pvaranasi95/DevOps.git']])
            }
        }
        stage('maven') {
            steps{
                withMaven {
                    node('Windows1') {
                          bat 'mvn clean install'
                    }
            }
        }
    }
    }
}

