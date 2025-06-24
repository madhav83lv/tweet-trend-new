pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
        PATH = "/opt/apache-maven-3.9.10/bin:$PATH"
    }

    stages {
        stage("Maven Build") {
            steps {
                sh 'mvn clean deploy -DskipTests'
            }
        }

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'sonarqube-scanner'
            }
            steps {
             // must match the name of an actual scanner installation directory on your Jenkins build agent
            withSonarQubeEnv('sonarqube-servers') { // If you have configured more than one global server connection, you can specify its name as configured in Jenkins
            sh "${scannerHome}/bin/sonar-scanner"
            }
            }
        }
    }
}