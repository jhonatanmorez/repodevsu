pipeline {
    agent any
    environment {
        PROJECT_ID = 'proyecto-gcp-395116'
        CLUSTER_NAME = 'k8sdevsu'
        LOCATION = 'us-central1'
        CREDENTIALS_ID = 'Proyecto-GCP'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage("Build image") {
            steps {
                script {
                   
                    myapp = docker.build("jorgemore/devsu-demo-devops-nodejs:${env.BUILD_ID}")
                   
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    
                    docker.withRegistry('https://registry.hub.docker.com', 'DropboxID') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                        
                }
            }
        }        
        stage('Deploy to GKE') {
            steps{
                
                sh "sed -i 's/devsu-demo-devops-nodejs:latest/devsu-demo-devops-nodejs:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            
            }      
        }
    }    
}
