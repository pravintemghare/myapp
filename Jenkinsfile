pipeline {
    agent any
    environment {
        DATE_TAG = java.time.LocalDate.now()
        currentDate = sh(returnStdout: true, script: 'date +%Y-%m-%d')
        NEW_TAG DATE_TAG = java.time.format.DateTimeFormatter.ofPattern("dd-MM-yyyy")
    }
    stages {
        stage('GitCheckout') {
            steps {
                sh 'echo ${currentDate}'
                checkout([$class: 'GitSCM', branches: [[name: "myapp${DATE_TAG}"]],
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
