pipeline {
    agent any
    environment {
        dockerRun = "docker run -itd -p 8080:8080 --network mynetwork --name myapp ptemghare/myapp"
    }
    stages {
        stage('GitCheckout') {
            steps {
                git(
                    branch: 'master',
                    credentialsId: 'github',
                    url: 'https://github.com/pravintemghare/myapp.git'
                )    
            }
        }
        stage('ApplicationBuild') {
            steps {
                withMaven(maven : 'maven8') {
                    sh 'mvn clean'
                }
            }
        }
        stage('ApplicationTest') {
            steps {
                withMaven(maven : 'maven8') {
                    sh 'mvn test'
                }
            }
        }
        stage('ApplicationPackage') {
            steps {
                withMaven(maven : 'maven8'){
                    sh 'mvn package'
                }
            }
        }
        stage('DockerBuild') {
            steps {
                sh 'docker build -t ptemghare/myapp:latest .'
            }
        }
        stage('DockerTag') {
            steps {
                sh 'docker tag ptemghare/myapp:latest ptemghare/myapp:latest'
                sh 'docker tag ptemghare/myapp:latest ptemghare/myapp:1.0'
            }
        }
        stage('DockerPush') {
            steps {
                sh 'docker login --username "ptemghare" --password "Sony@1902" docker.io'
                sh 'docker push ptemghare/myapp:latest'
                sh 'docker push ptemghare/myapp:1.0'
            }
        }
        stage('DockerDeploy') {
            steps {
                sshagent(['sshlogin-dev']) {
                    sh 'ssh -o StrictHostKeyChecking=no root@192.168.37.178 ${dockerRun}'
                }     
            }
        }
    }
}