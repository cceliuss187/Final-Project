pipeline {
  agent any
   stages {
     
    stage ('Build') {
      steps {
        sh '''#!/bin/bash
        python3 -m venv kodespace
        source kodespace/bin/activate
        pip install pip --upgrade
        pip install -r requirements.txt
        export FLASK_APP=application
        flask run &
        '''
          }
         }
    
  
  
    stage ('test') {
      steps {
        sh '''#!/bin/bash
        source kodespace/bin/activate
        py.test --verbose --junit-xml test-reports/results.xml
        ''' 
      }
    
      post{
        always {
          junit 'test-reports/results.xml'
        }
       
      }
    }
     
     
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
          sudo docker tag kodespace:latest kodespace01/kodespace-website:latest
          sudo docker push kodespace01/kodespace-website:latest
          '''                      
         
    }
   }
     stage('Staging') {
       steps {
        dir('docker') {
          sh 'sudo docker compose up' 
           }
         }
    }
     
     stage('Init') {
       steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')]) {
                            dir('interTerraform') {
                              sh 'terraform init' 
                            }
         }
    }
   }
      stage('Plan') {
       steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')]) {
                            dir('interTerraform') {
                              sh 'terraform plan -out plan.tfplan -var="aws_access_key=$aws_access_key" -var="aws_secret_key=$aws_secret_key"' 
                            }
         }
    }
   }
      stage('Apply') {
       steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')]) {
                            dir('interTerraform') {
                              sh 'terraform apply plan.tfplan' 
                            }
         }
    }
   }
  }
}
