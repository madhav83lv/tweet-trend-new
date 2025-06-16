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
        stage('Clone-src') {
            steps {
                git branch: 'main', url: 'https://github.com/madhav83lv/tweet-trend-new.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean deploy -U'
            }
        }
    }
}