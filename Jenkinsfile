pipeline {
  agent any
   stages {
     stage('Create Container') {
       agent{label 'docker-agent'}
       steps { 
            dir('docker') {
                sh 'sudo docker build -t kodespace .' 
            }
         
    }
   }
     
     stage('Push to DockerHub') {
       agent{label 'docker-agent'}
       steps {        
          sh '''#!/bin/bash
          sudo docker tag kodespace:latest antoniorios17/kodespace:latest
          sudo docker push antoniorios17/kodespace:latest
          '''                      
         
    }
   }
   
   
   
    }
 }
