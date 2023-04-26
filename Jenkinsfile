node ("slave-kreditmu-gcp") {
    dir ("${env.BUILD_ID}") {
	    def APP_REPO_URL = "https://github.com/KB-FMF/deasy.git"
        def APP_REPO_DEVOPS_URL = "https://github.com/KB-FMF/devops-config.git"
	    def CREDENTIAL_ID = "6a343df1-5844-47af-9a40-aacd60fa75b3"

        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[
			credentialsId: "${CREDENTIAL_ID}", 
		  	url: "${APP_REPO_URL}"]], 
		  	branches: [[name: "refs/tags/${tag}"]
		]]

        def DOCKER_REGISTRY_GCR = "asia.gcr.io"
        def PROJECT_ID_GCP = "devops-314404" //container registry project
		def DOCKER_IMAGE = "deasy-web-prod"     

        def DOCKER_TAG = "${tag}"

        def K8S_NAMESPACE = "deasy"
		def K8S_MANIFEST_PATH = "k8s/prod/config-deasy/deasy-web"

        def GKE_CLUSTER_NAME = "cluster-deasy-prod"
        def GKE_REGION = "asia-southeast2"
        def GKE_PROJECT_ID = "deasy-production"

        def SLACK_CHANNEL = "merchant-builds"

        currentBuild.displayName="#${BUILD_NUMBER}, ${JOB_NAME}, ${DOCKER_TAG}"
        try {
            notifyBuild('STARTED', DOCKER_IMAGE, DOCKER_TAG, K8S_NAMESPACE, SLACK_CHANNEL)

            stage ('Git Checkout') {
                echo 'Git Checkout'
                dir("k8s"){
                        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[
                        credentialsId: "${CREDENTIAL_ID}", 
                        url: "${APP_REPO_DEVOPS_URL}"]], 
                        branches: [[name: "*/master"]
                    ]] 
                }   
            }

            stage ('Docker Build') {
                echo 'Docker Build'
                buildImage(DOCKER_REGISTRY_GCR, PROJECT_ID_GCP, DOCKER_IMAGE, DOCKER_TAG, K8S_MANIFEST_PATH, WORKSPACE, BUILD_ID)    
            }

            stage ('Push Image to GCR') {
                echo 'Push Image to GCR'
                pushImage(DOCKER_REGISTRY_GCR, PROJECT_ID_GCP, DOCKER_IMAGE, DOCKER_TAG) 
            }

            stage ('Deploy to k8s') {
                echo 'Deploy to k8s'
                deployK8s(DOCKER_REGISTRY_GCR, PROJECT_ID_GCP, DOCKER_IMAGE, DOCKER_TAG, K8S_NAMESPACE, K8S_MANIFEST_PATH, WORKSPACE, BUILD_ID, GKE_CLUSTER_NAME, GKE_REGION, GKE_PROJECT_ID)    
            }
                    
        } catch (e) {
            // If there was an exception thrown, the build failed
            currentBuild.result = "FAILED"
            throw e
        } finally {
            // Success or failure, always send notifications
            notifyBuild(currentBuild.result, DOCKER_IMAGE, DOCKER_TAG, K8S_NAMESPACE, SLACK_CHANNEL)
            cleanWs()
        }
    } //dir
} //node

def buildImage(String DockerRegistryGcr, String ProjectId, String DockerImage, String DockerTag, String K8sManifestPath, String Workspace, String BuildId) {
	echo "Build Image"
		sh """
			#!/bin/bash
            sed -i 's|lib/flavor/dev/main_dev.dart|lib/flavor/prod/main_prod.dart|g'  ${Workspace}/${BuildId}/Dockerfile
			sudo docker build -t ${DockerRegistryGcr}/${ProjectId}/${DockerImage}:${DockerTag} -f Dockerfile .
		"""
}

def pushImage(String DockerRegistryGcr, String ProjectId, String DockerImage, String DockerTag) {
	echo "Push Image To GCR"
    withDockerRegistry(credentialsId: 'gcr:gcr-sa', url: 'https://asia.gcr.io') {    
        sh """
            #!/bin/bash
            sudo docker push ${DockerRegistryGcr}/${ProjectId}/${DockerImage}:${DockerTag}
            sudo docker rmi ${DockerRegistryGcr}/${ProjectId}/${DockerImage}:${DockerTag}
        """
    }
}

def deployK8s(String DockerRegistryGcr, String ProjectIdGcp, String DockerImage, String DockerTag, String K8sNamespace, String K8sManifestPath, String Workspace, String BuildId, String GkeClusterName, String GkeRegion, String GkeProjectId) {
	echo "Deploy to k8s"
    withCredentials([file(credentialsId: 'sa-gke-deasy-production', variable: 'SACRED')]) {
		sh """
			#!/bin/bash
            gcloud auth activate-service-account --key-file=$SACRED
            gcloud container clusters get-credentials ${GkeClusterName} --region=${GkeRegion} --project=${GkeProjectId}
            cp /root/.kube/config ${Workspace}/${BuildId}/kubeconfig
            sed -i 's/DockerRegistry/'"${DockerRegistryGcr}"'/g'  ${Workspace}/${BuildId}/${K8sManifestPath}/deployment.yaml
            sed -i 's/ProjectID/'"${ProjectIdGcp}"'/g'  ${Workspace}/${BuildId}/${K8sManifestPath}/deployment.yaml
			sed -i 's/DockerImage/'"${DockerImage}"'/g'  ${Workspace}/${BuildId}/${K8sManifestPath}/deployment.yaml
			sed -i 's/DockerTag/'"${DockerTag}"'/g'  ${Workspace}/${BuildId}/${K8sManifestPath}/deployment.yaml
            kubectl --kubeconfig=./kubeconfig apply -f ./${K8sManifestPath}/deployment.yaml --namespace=${K8sNamespace}
			kubectl --kubeconfig=./kubeconfig apply -f ./${K8sManifestPath}/service.yaml --namespace=${K8sNamespace}
		"""
    }    
}

def notifyBuild(String buildStatus = 'STARTED', String dockerImage, String dockerTag, String k8sNamespace, String SlackChannel) {
  // Build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESS'

  // Default values
  def icons = [":rocket:", ":tada:", ":mega:", ":dancer:", ":technologist:", ":scientist:"]
  def randomIndex = (new Random()).nextInt(icons.size())
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job `${env.JOB_NAME}` tag `${dockerTag}` ${icons[randomIndex]} \n :diamond_shape_with_a_dot_inside: Docker Image: `${dockerImage}:${dockerTag}` \n :diamond_shape_with_a_dot_inside: Namespace: `${k8sNamespace}`"
  def summary = "${subject} \n (${env.BUILD_URL})"
  def slackChannel = "${SlackChannel}"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'GREY'
    colorCode = '#D4DADF'
  } else if (buildStatus == 'SUCCESS') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else if (buildStatus == 'UNSTABLE') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary, channel: slackChannel)
}