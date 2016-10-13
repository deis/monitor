#!groovy
def quayUsername = "deis+jenkins"
def quayEmail = "deis+jenkins@deis.com"
def hubUsername = "deisbot"
def hubEmail = "dummy-address@deis.com"

stage 'Build Grafana'
node {
  checkout scm
  withCredentials([[$class: 'StringBinding',
                    credentialsId: '8317a529-10f7-40b5-abd4-a42f242f22f0',
                    variable: 'QUAY_PASSWORD'],
                  [$class: 'StringBinding',
                    credentialsId: '0d1f268f-407d-4cd9-a3c2-0f9671df0104',
                    variable: 'DOCKER_PASSWORD']]) {
  //  setGitHubPullRequestStatus state: 'PENDING', message: "Run #${env.BUILD_NUMBER} started"
   sh """
     cd grafana
     docker login -e="${quayEmail}" -u="${quayUsername}" -p="\${QUAY_PASSWORD}" quay.io
     make build docker-immutable-push

     docker login -e="${hubEmail}" -u="${hubUsername}" -p="\${DOCKER_PASSWORD}"
     REGISTRY='' make build docker-immutable-push
   """
  }
}



stage 'Build Influxdb'
node {
  checkout scm
  withCredentials([[$class: 'StringBinding',
                    credentialsId: '8317a529-10f7-40b5-abd4-a42f242f22f0',
                    variable: 'QUAY_PASSWORD'],
                  [$class: 'StringBinding',
                    credentialsId: '0d1f268f-407d-4cd9-a3c2-0f9671df0104',
                    variable: 'DOCKER_PASSWORD']]) {
  //  setGitHubPullRequestStatus state: 'PENDING', message: "Run #${env.BUILD_NUMBER} started"
   sh """
     cd influxdb
     docker login -e="${quayEmail}" -u="${quayUsername}" -p="\${QUAY_PASSWORD}" quay.io
     make build docker-immutable-push

     docker login -e="${hubEmail}" -u="${hubUsername}" -p="\${DOCKER_PASSWORD}"
     REGISTRY='' make build docker-immutable-push
   """
  }
}

stage 'Build Telegraf'
node {
  checkout scm
  withCredentials([[$class: 'StringBinding',
                    credentialsId: '8317a529-10f7-40b5-abd4-a42f242f22f0',
                    variable: 'QUAY_PASSWORD'],
                  [$class: 'StringBinding',
                    credentialsId: '0d1f268f-407d-4cd9-a3c2-0f9671df0104',
                    variable: 'DOCKER_PASSWORD']]) {
  //  setGitHubPullRequestStatus state: 'PENDING', message: "Run #${env.BUILD_NUMBER} started"
   sh """
    cd telegraf
    docker login -e="${hubEmail}" -u="${hubUsername}" -p="\${DOCKER_PASSWORD}"
    REGISTRY='' make build docker-immutable-push

    docker login -e="${hubEmail}" -u="${hubUsername}" -p="\${DOCKER_PASSWORD}"
    REGISTRY='' make build docker-immutable-push
   """
  }
}
