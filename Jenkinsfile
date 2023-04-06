pipeline {
    agent any

    tools {
        maven "maven"
    }

    stages {
        stage('Git checkout') {
            steps {
              
                   git 'https://github.com/ambikasharma1990/bank-finance.git'
            
                }
            }
        stage('maven build') {
              steps {
              
                     sh "mvn install package"
                }
        }
        
        stage('Publish HTML') {
              steps {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/bank-proj/target/surefire-reports', reportFiles: 'index.html', reportName: 'project-02-HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
        }
        
          stage('Docker build image') {
              steps {
                  sh 'sudo docker build -t rambikasharma/bank-finance:1.0 .'
              
                }
            }
                
        stage('Docker login and push') {
              steps {
                   withCredentials([string(credentialsId: 'docpass', variable: 'docpasswd')]) {
                  sh 'sudo docker login -u rambikasharma -p ${docpasswd} '
                  sh 'sudo docker push rambikasharma/bank-finance:1.0 '
                  }
                }
        }    
                
        stage (' configuring Test-server with terraform & ansible and deploying'){
            steps{

                dir('test-server'){
                sh 'sudo chmod 600 project2.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
               
            }
        }

        stage('waitng to start the app') {
              steps {
                  
                  sh ' sleep 40'
                           
                }
            }
       
          
         
        

        
    }
}
