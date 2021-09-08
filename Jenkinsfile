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
                withMaven(maven : 'mvn') {
                    sh 'mvn clean'
                }
            }
        }
        stage('ApplicationTest') {
            steps {
                withMaven(maven : 'mvn') {
                    sh 'mvn test'
                }
            }
        }
        stage('ApplicationPackage') {
            steps {
                withMaven(maven : 'mvn'){
                    sh 'mvn package'
                }
            }
        }
        stage('Ansible_Docker_build') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook -i /opt/myapp/hosts/create-docker-image.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//myapp', remoteDirectorySDF: false, removePrefix: 'target/', sourceFiles: 'target/*jar')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}