pipeline {
    agent any
    environment {
        BUILD_TAG = 'sh "echo myapp$(date +"%Y%m%d")"'
        DATE_TAG = java.time.LocalDate.now()
    }
    stages {
        stage('GitCheckout') {
            steps {
                sh "echo ${DATE_TAG}"
                sh "echo ${BUILD_TAG}"
                checkout([$class: 'GitSCM', branches: [[name: "myapp$(date +"%Y%m%d")"]],
                  userRemoteConfigs: [[url: 'https://github.com/pravintemghare/myapp.git',
                                       credentialsId: 'GitHub']]
                ])    
            }
        }
        stage('ApplicationBuild') {
            steps {
                withMaven(maven : 'mvn83') {
                    sh 'mvn clean'
                }
            }
        }
        stage('ApplicationTest') {
            steps {
                withMaven(maven : 'mvn83') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=MyApp -Dsonar.host.url=http://localhost:9000 -Dsonar.login=bf67e885d05af00c9ce983e603ec07ac7b7083f0'
                }
            }
        }
        stage('ApplicationPackage') {
            steps {
                withMaven(maven : 'mvn83'){
                    sh 'mvn package'
                }
            }
        }
    }
}
