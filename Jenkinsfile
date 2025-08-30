pipeline {
    agent any

    tools {
        jdk 'JDK11'
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

        stage('Copy WAR to workdir') {
            steps {
                powershell """
                \$source = "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Adressbook\\target\\addressbook.war"
                \$destination = "${params.WorkDir}"
                Copy-Item -Path \$source -Destination \$destination -Force
                """
            }
        }

        stage('Upload to Artifactory') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory-creds', usernameVariable: 'ART_USER', passwordVariable: 'ART_PASS')]) {
                    bat """
                    curl -v -u %ART_USER%:%ART_PASS% -T "${params.WorkDir}\\addressbook.war" ^
                    "http://localhost:8082/artifactory/addressbook_CICD/addressbook/%BUILD_NUMBER%/addressbook.war"
                    """
                }
            }
        }
    }
}
