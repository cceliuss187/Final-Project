pipeline {
  agent any
   stages {
    stage('Create Container') {
       steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')]) {
                            dir('docker') {
                              sh 'sudo docker build -t kodespace .' 
                            }
         }
    }
   }
     
     stage('Push to DockerHub') {
       steps {        
          sh '''#!/bin/bash
          sudo docker tag kodespace:latest antoniorios17/kodespace:latest
          sudo docker push antoniorios17/kodespace:latest
          '''                      
         
    }
   }
  }
}
