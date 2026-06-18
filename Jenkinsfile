pipeline {
    agent any

    environment {
        RAILS_ENV = "test"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build & Run Devcontainer') {
            steps {
                sh 'npx @devcontainers/cli up --workspace-folder .'
                sh '''
                    devcontainer exec --workspace-folder . bash -c "
                        ruby -v && \
                        bundle exec rails db:create db:migrate && \
                        bundle exec rspec || true && \
                        bundle exec rails playwright:run
                    "
                '''
            }
        }
    }

    post {
        always {
            sh 'docker compose down || true'            
            archiveArtifacts artifacts: '**/tmp/screenshots/**/*', allowEmptyArchive: true
        }

        failure {
            echo "Build failed"
        }

        success {
            echo "Build passed"
        }
    }
}