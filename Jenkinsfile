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
                withMaven {
                    node('Windows1') {
                          bat 'mvn clean install'
                    }
            }
        }
    }
        stage('Sonar Scan') {
            steps{
                sh 'mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=Pipeline1 \
                    -Dsonar.projectName='Pipeline1' \
                    -Dsonar.host.url=http://localhost:9000 \
                    -Dsonar.token=sqp_443e25e4b841be8d66131cd5057645e151c1f890
            }
        }

}
}
