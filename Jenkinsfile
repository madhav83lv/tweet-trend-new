pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    stages {
        stage('Clone-src') {
            steps {
                git branch: 'main', url: 'https://github.com/madhav83lv/tweet-trend-new.git'
            }
        }
    }
}