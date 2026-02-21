// Loads central pipeline from CICD repo

node {
    stage('Load Central Pipeline') {

        git branch: 'main',
            url: 'https://github.com/pvaranasi95/CICD.git'

        load 'Jenkinsfile'
    }
}
