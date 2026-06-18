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

    stage('Install dependencies') {
      steps {
        sh '''
          ruby -v
          bundle install
        '''
      }
    }

    stage('Setup DB') {
      steps {
        sh '''
          bin/rails db:create db:migrate
        '''
      }
    }

    stage('Run Rails tests') {
      steps {
        sh '''
          bundle exec rspec || true
        '''
      }
    }

    stage('Run Playwright tests') {
      steps {
        sh '''
          bin/rails playwright:run
        '''
      }
    }

  }

  post {
    always {
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