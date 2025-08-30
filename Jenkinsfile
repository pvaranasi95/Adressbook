pipeline {
    agent any

    tools {
        jdk 'JDK11'
        maven 'Maven'
    }
    stages {
        stage('Read Config') {
            steps {
                script {
                    def props = readYaml file: 'properties.yaml'

                    // Save to env vars
                    env.WORKSPACE_PATH = props.workspace
                    env.ARTIFACTORY_REPO = props.artifactory_repo
                    env.ARTIFACTORY_URL = props.artifactory_url
                    env.ARTIFACTORY_CREDS = props.artifactory_credentials

                    echo "Workspace Path: ${env.WORKSPACE_PATH}"
                    echo "Artifactory Repo: ${env.ARTIFACTORY_REPO}"
                    echo "Artifactory URL: ${env.ARTIFACTORY_URL}"
                    echo "Credentials ID: ${env.ARTIFACTORY_CREDS}"
                }
            }
        }
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
                \$destination = "${env.WORKSPACE_PATH}"
                Copy-Item -Path \$source -Destination \$destination -Force
                """
            }
        }

        stage('Upload to Artifactory') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${env.ARTIFACTORY_CREDS}", usernameVariable: 'ART_USER', passwordVariable: 'ART_PASS')]) {
                    bat """
                    curl -v -u %ART_USER%:%ART_PASS% -T "${env.WORKSPACE_PATH}\\addressbook.war" ^
                    "http://localhost:8082/artifactory/${env.ARTIFACTORY_REPO}/addressbook/%BUILD_NUMBER%/addressbook.war"
                    """
                }
            }
        }
    }
}
