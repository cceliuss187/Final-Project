pipeline {
  agent any
   stages {
    stage('Create Container') {
       steps {
        dir('docker') {
          sh 'sudo docker build -t kodespace .' 
                            }
         }
    }
   
     
     stage('Push to DockerHub') {
       steps {        
          sh '''#!/bin/bash
          sudo docker tag kodespace:latest kodespace01/kodespace:latest
          sudo docker push kodespace01/kodespace:latest
          '''                      
         
    }
   }
  }
}
