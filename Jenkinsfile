pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    stages {
        stage("Maven Build") {
            steps {
                sh 'mvn clean deploy -Dmaven.test.skip=true'
            }
        }
    }
}