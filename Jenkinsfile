pipeline {
    agent any

    tools {
        jdk 'JDK11'   // Change to JDK17 if needed
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
                powershell '''
                Compress-Archive -Path "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook\\*" -DestinationPath "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook.zip" -Force
                '''
            }
        }

        stage('Copy workspace') {
            steps {
                bat '''
                xcopy /E /I /Y ^
                "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook.zip" ^
                "C:\\ProgramData\\Jenkins\\workspace\\Backup\\"
                '''
            }
        }
    }
}
