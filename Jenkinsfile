pipeline {
    agent any

    tools {
        jdk 'JDK11'   // Change to JDK17 if needed
        maven 'Maven'
    }
    parameters {
    string(name: 'WorkDir', defaultValue: 'C:\\Users\\pavan\\OneDrive\\Desktop\\DevOps\\Build', description: 'WAR destination path')
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

        stage('Maven Validate') {
            steps {
                bat "mvn validate"
            }
        }

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

        stage('Package workspace') {
            steps {
                powershell """
                \$source = "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook\\target\\addressbook.war"
                \$destination = "${params.WorkDir}"
                Copy-Item -Path \$source -Destination \$destination -Force
                """
            }
        }
        stage('Docker Image')  {
            steps {
                powershell """
                cd "${params.WorkDir}"
                docker build -t pvaranasi/addressbook:\$env:BUILD_NUMBER .
                """
                }
            }
     stage('Docker Push') {
        steps {
            withCredentials([usernamePassword(credentialsId: 'pvaranasi-dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            powershell """
            docker login -u \$env:DOCKER_USER -p \$env:DOCKER_PASS
            docker push pvaranasi/addressbook:\$env:BUILD_NUMBER
            """
        }
    }
}
    }
}
