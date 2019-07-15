#!groovy

pipeline {
  agent any
      tools { 
        jdk 'jdk' 
            }
            
  stages {
    stage('Preparing Environment') {
      steps {
          // using the one of the containers jnlp, if you are not using any specific container you will use nodes alone. Clone Routing repo to workspace
          git branch: 'master',  url: 'https://github.com/ramimmadi/newpetclinicapp-1.git'
      }  
    }
    stage('Packaging and Sonar analysis') {
      environment {
         // Create the BUILD ID from Date and Git Commit
         BUILD_ID = sh(returnStdout: true, script: 'echo "`git rev-parse --verify HEAD`"').take(8)
      }
      steps {
          // Run Maven install
   
            script {  
                withSonarQubeEnv('sonar') {
                  
                   sh 'mvn clean install -Dmaven.test.skip=true sonar:sonar'
                  
                  
            }
          }    
    
      }
    }
    
   /* stage("Quality Gate") {
            steps {
              timeout(time: 3, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
          }*/
          
 /*   stage("Quality Gate") {
       steps {
           script {
             timeout(time: 5, unit: 'MINUTES') {
             def qg = waitForQualityGate()
             if (qg.status != 'OK') {
               error "Pipeline aborted due to quality gate failure: ${qg.status}"  
             }
           }    
         }
       }  
     } */
   stage('Artificate upload') {
      //Create the Artificate and move it to Nexus repo
      steps {
          nexusArtifactUploader ( artifacts: [[artifactId: 'petclinic', classifier: '', file: 'target/petclinic.war', type: 'war']], credentialsId: 'nexuscred', groupId: 'com.groupID', nexusUrl: '10.0.0.18:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases',
          version: '$JOB_NAME-$BUILD_NUMBER')
      }
    }
  /*  stage('Dependency Check') {
      steps {
        container('jnlp')  {
          dependencyCheckAnalyzer datadir: '', hintsFile: '', includeCsvReports: false, includeHtmlReports: true, includeJsonReports: false, includeVulnReports: true, isAutoupdateDisabled: false, outdir: '', scanpath: '', skipOnScmChange: false, skipOnUpstreamChange: false, suppressionFile: '', zipExtensions: ''
          dependencyCheckPublisher canComputeNew: false, canRunOnFailed: true, defaultEncoding: '', healthy: '90', pattern: '', shouldDetectModules: true, unHealthy: ''
        }
      }
    } */
    stage('Create Docker Image') {
      environment {
        // Create the BUILD ID from Date and Git Commit
        BUILD_ID = sh(returnStdout: true, script: 'echo "`git rev-parse --verify HEAD`"').take(8)
      }
      steps {
          sh "echo *********************************** Create Docker Image  *************** "
          sh "gcloud auth configure-docker"
          sh "docker build -t gcr.io/project-test-to/rbs-repo/petclinic:${JOB_NAME}-${BUILD_NUMBER} ."
      //    sh "gcloud auth activate-service-account --key-file=/opt/bitnami/apps/jenkins/jenkins_home/workspace/rbs-storage.json"
      //    sh "docker push gcr.io/project-test-to/rbs-repo/petclinic:${JOB_NAME}-${BUILD_NUMBER}"
      } 
  }
  
      stage('push image to GCR') {
      environment {
        // Create the BUILD ID from Date and Git Commit
        BUILD_ID = sh(returnStdout: true, script: 'echo "`git rev-parse --verify HEAD`"').take(8)
      }
      steps {
          sh "echo *********************************** Create Docker Image and push to GCR *************** "
          sh "gcloud auth configure-docker"
      //    sh "docker build -t gcr.io/project-test-to/rbs-repo/petclinic:${JOB_NAME}-${BUILD_NUMBER} ."
          sh "gcloud auth activate-service-account --key-file=/opt/bitnami/apps/jenkins/jenkins_home/workspace/rbs-storage.json"
          sh "docker push gcr.io/project-test-to/rbs-repo/petclinic:${JOB_NAME}-${BUILD_NUMBER}"
      } 
  }
 
//    stage('publish') {
    // publish all code coverage reports
  //    steps {
          // Find and save all reports
 //         junit '*/target/-reports/*.xml'
   //       jacoco(execPattern: '**/target/jacoco.exec')
 //   }
 // }
  }
 
 post {
        success {
            mail to:"ramueswari123@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "all the stages are successful expect the deployment in dev in few moments"
        }
        failure {
            mail to:"ramueswari123@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Pipeline broke please check what went wrong."
        }
    }  
 
 // The options directive is for configuration that applies to the whole job.
  options {
    // Delete builds except for #
    buildDiscarder(logRotator(numToKeepStr:'10'))
 
    //Timeout job if taking too long
    timeout(time: 10, unit: 'MINUTES')
  }
}
