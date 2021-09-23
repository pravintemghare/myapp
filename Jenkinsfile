pipeline {
    agent any
    environment {
        DATE_TAG = sh(returnStdout: true, script: 'date +%d%m%Y')  
    }
    
    stages {
        stage('GitCheckout') {
            steps {
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
        stage('Ansible_Docker_build') {
            steps {
                ansiblePlaybook become: true, credentialsId: 'ansible_host', -e 'build_tag = $BUILD_ID', installation: 'ansible', inventory: 'ansible_playbooks/hosts', playbook: 'ansible_playbooks/create_docker_image.yml', vaultCredentialsId: 'ansible_vault_password'
            }
        }
    }
}
