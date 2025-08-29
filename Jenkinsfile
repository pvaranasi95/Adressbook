pipeline {
    agent any

    tools {
        jdk 'JDK11'   // Or 'JDK17' if configured
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

        stage('Sonar scan') {
            steps {
                bat '''
                mvn clean verify sonar:sonar ^
                -Dsonar.projectKey=Address-Book ^
                -Dsonar.projectName="Address Book" ^
                -Dsonar.host.url=http://localhost:9000 ^
                -Dsonar.token=sqp_0ea1297d3b0f75c5bedfe7f4d047fe28b9177280
                '''
            }
        }
        stage('Copy changes to workdir') {
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
                script {
                    rtServer (
                        id: "jfrog-dev",
                        url: "http://localhost:8082/artifactory",
                        credentialsId: "Artifactory"
                        )
                    rtUpload (
                        serverId: 'jfrog-dev',
                        spec: """{
                            "files": [
                                {
                                    "pattern": "${params.WorkDir}/addressbook.war",
                                    "target": "addressbook/${env.BUILD_NUMBER}/"
                                }
                            ]
                        }""",
                        buildName: env.JOB_NAME,
                        buildNumber: env.BUILD_NUMBER,
                        project: 'Adressbook'
                    )
                }
            }
        }
    }
}
