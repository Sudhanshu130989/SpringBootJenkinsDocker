pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Sudhanshu130989/SpringBootJenkinsDocker.git'
            }
        }

        stage('Build Maven') {
            steps {
                // Clean and build JAR, skip tests
                sh "mvn clean package -DskipTests"
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image from Dockerfile
                sh "docker build -t springbootdockerjenckin ."
            }
        }

        stage('Run Container') {
            steps {
                // Stop and remove previous container (if exists)
                sh "docker stop springbootdockerjenckin || true"
                sh "docker rm springbootdockerjenckin || true"

                // Run container detached
                sh "docker run -d -p 9090:8080 --name springbootdockerjenckin springbootdockerjenckin"
            }
        }
    }

    post {
        success {
            echo "Spring Boot application deployed successfully!"
            echo "Access it at: http://localhost:9090/"
        }
        failure {
            echo "Build or deployment failed."
        }
    }
}
