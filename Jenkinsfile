pipeline{
  agent any

  stages{
    stage('Clone'){
        steps{
           git branch: 'main', url: 'https://github.com/Sudhanshu130989/SpringBootJenkinsDocker.git'
        }
    }
    stage('Build Maven'){
         steps{
          sh "mvn clean package -DskipTests"
         }
    }
    stage('Build Docker Image'){
       steps{
         sh "docker build -t springbootdockerjenckin ."
       }
    }
    stage('Run Containe'){
       steps{
         sh "docker stop springbootdockerjenckin || true"
         sh "docker rm springbootdockerjenckin || true"
         sh "docker run -d -p 9090:8080 --name springbootdockerjenckin springbootdockerjenckin"
       }
    }

  }
    post {
       success{
         echo "Spring Boot available at : http://localhost:9090/"
       }
       failure{
          echo "Build or deployment failed :"
       }
    }
}