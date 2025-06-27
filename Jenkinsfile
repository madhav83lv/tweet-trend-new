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
                scannerHome = tool 'sonarqube-scanner' // Tools > SonarScanner
             } 
            steps {
            withSonarQubeEnv('sonarqube-servers') { // System > SonarQube Servers
            sh "${scannerHome}/bin/sonar-scanner"
            }
            }
        }
    }
}