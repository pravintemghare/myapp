pipeline {
    agent any
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
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook -i /opt/myapp/hosts /opt/myapp/create-docker-image.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//myapp', remoteDirectorySDF: false, removePrefix: 'target', sourceFiles: 'target/*.jar')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage('Ansible_Deploy_Kubernetes') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''ansible-playbook -i /opt/myapp/hosts /opt/myapp/kubernetes-myapp-deploy.yml;
ansible-playbook -i /opt/myapp/hosts /opt/myapp/kubernetes-myapp-service.yml''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}