def registry = 'https://open05.jfrog.io'
def imageName = 'open05.jfrog.io/open-docker-local/open'
def version = '2.1.2'
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
      /*  stage("Quality Gate") {
            steps {
                script {
                timeout(time: 1, unit: 'HOURS') {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted: ${qg.status}"
                    }
                }
                }
            }
        }  */
        stage("Jar Publish") {
            steps {
            script {
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-cred" //Jenkins > Credentials
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",  
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
            }
            }
        } 
        stage("Docker Build") {
            steps {
                script {
                    app = docker.build(imageName+":"+version)
                }
            }
        }
        stage("Docker Publish") {
            steps {
                script {
                    docker.withRegistry(registry, 'jfrog-cred') {
                        app.push()
                    }
                }
            }
        }
    }
}

//docker images
//docker run -dt --name trend-cont -p 8000:8000 <image_name:tag>
//docker ps -a