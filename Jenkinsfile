pipeline {
  agent any
   stages {
     stage('Create Container') {
       steps { 
            dir('Docker') {
                sh 'sudo docker build -t kodespace .' 
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
