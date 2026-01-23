
pipeline {
    agent any
  environment {
    DOCKER_CRED = credentials('DOCKER_CRED')
}

    tools {
        jdk 'JDK17'   // Or 'JDK17' if configured
        maven 'Maven'
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/pvaranasi95/DevOps.git']]
                )
            }
        }

        // stage('Maven Validate') {
        //     steps {
        //         bat "mvn validate"
        //     }
        // }

        stage('Maven Package') {
            steps {
                bat "mvn clean install"
            }
        }

        // stage('Sonar scan') {
        //     steps {
        //         bat '''
        //         mvn clean verify sonar:sonar ^
        //         -Dsonar.projectKey=Address-Book ^
        //         -Dsonar.projectName="Address Book" ^
        //         -Dsonar.host.url=http://localhost:9000 ^
        //         -Dsonar.token=sqp_0ea1297d3b0f75c5bedfe7f4d047fe28b9177280
        //         '''
        //     }
        // }

        stage('Copy changes to Docker folder') {
            steps {
                powershell """
                \$source = "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook_Docker\\target\\addressbook.war"
                \$destination = "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook_Docker\\"
                Copy-Item -Path \$source -Destination \$destination -Force
                """
                bat '''
                echo "Copy completed, Proceeding to next stage"
                '''
            }
        }


stage('Build Docker Image') {
    steps {
        script {
            bat "docker build -t adressbook_%BUILD_NUMBER%:latest ."
        }
    }
}
                stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'DOCKER_CRED',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat '''
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    '''
                }
            }
        }
      stage('Push Docker Image to Docker Hub'){
        steps{
          script{
            bat "docker push pvaranasi/adressbook_%BUILD_NUMBER%"
          }
        }
      }
      
    }
}
