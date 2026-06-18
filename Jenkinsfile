pipeline {
    agent any

    environment {
        RAILS_ENV = "test"
        DATABASE_URL = "postgres://postgres:postgres@postgres:5432/postgres"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Start Postgres') {
            steps {
                sh 'docker compose up -d postgres'
            }
        }

        stage('Wait DB') {
            steps {
                sh '''
                echo "Waiting for postgres..."
                until docker exec $(docker ps -qf name=postgres) pg_isready -U postgres; do
                  sleep 2
                done
                '''
            }
        }

        stage('Build Rails container') {
            steps {
                sh 'docker compose build rails-app'
            }
        }

        stage('DB Setup + Tests') {
            steps {
                sh '''
                docker compose run --rm rails-app bash -c "
                  bundle install &&
                  rails db:create db:migrate &&
                  rails test
                "
                '''
            }
        }
    }

    post {
        always {
            sh 'docker compose down -v'
        }
    }
}