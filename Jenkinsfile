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
                sh 'mvn clean deploy -Dmaven.test.skip=true'
            }
        }
        stage("Unit Test") {
            steps {
                sh 'mvn surefire-report:report'
            }
        }
        stage('SonarQube analysis') { //https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/ci-integration/jenkins-integration/add-analysis-to-job/#other
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