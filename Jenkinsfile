pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/pvaranasi95/DevOpsClassCodes.git']])
            }
        }
        stage('maven') {
            steps{
                withMavenEnv('Maven'){
                          sh 'mvn clean install'
                    }
            }
        }
    }
}

