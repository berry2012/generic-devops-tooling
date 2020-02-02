#!/bin/bash


# --------Objectives
# Creating a Kubernetes cluster with Kubernetes Engine.
# Creating a Jenkins deployment and services.
# Connecting to Jenkins.

export ZONE=[zone]
export CLUSTER_NAME=[cluster_name]


# ----Prepare the Environment

# Set the default Compute Engine zone to us-east1-d.

gcloud config set compute/zone $ZONE

# Clone the sample code.

git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes.git

# Navigate to the sample code directory.

cd continuous-deployment-on-kubernetes

# Creating a Kubernetes cluster
gcloud container clusters create $CLUSTER_NAME \
--num-nodes 2 \
--machine-type n1-standard-2 \
--scopes "https://www.googleapis.com/auth/projecthosting,cloud-platform"
# FYI - The extra scopes enable Jenkins to access Cloud Source Repositories and Google Container Registry.
# Confirm that your cluster is running.

# Get the credentials for your cluster. Kubernetes Engine uses these credentials to access your newly provisioned cluster.

gcloud container clusters get-credentials $CLUSTER_NAME 
# -------- Install Helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz

# Unzip the file in Cloud Shell:
tar zxfv helm-v2.9.1-linux-amd64.tar.gz
cp linux-amd64/helm .

# Add yourself as a cluster administrator in the cluster's RBAC so that you can give Jenkins permissions in the cluster:

kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)

# Grant Tiller, the server side of Helm, the cluster-admin role in your cluster:

kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

# Initialize Helm. This ensures that the server side of Helm (Tiller) is properly installed in your cluster.

./helm init --service-account=tiller
./helm repo update

# Ensure Helm is properly installed by running the following command. You should see versions appear for both the server and the client of v2.9.1:

./helm version


# -------- Configure and Install Jenkins
# You will use a custom values file to add the GCP specific plugin necessary to use service account credentials to reach your Cloud Source Repository.

# Use the Helm CLI to deploy the chart with your configuration set.

./helm install -n cd stable/jenkins -f jenkins/values.yaml --version 0.16.6 --wait


# Now, check that the Jenkins Service was created properly:

cat - << EOF 


# Run the following command to setup port forwarding to the Jenkins UI from the Cloud Shell 
    export POD_NAME=$(kubectl get pods -l "component=cd-jenkins-master" -o jsonpath="{.items[0].metadata.name}")
    kubectl port-forward $POD_NAME 8080:8080 >> /dev/null &

# The Jenkins chart will automatically create an admin password for you. To retrieve it, run:
    printf $(kubectl get secret cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

# Configure the Jenkins service account to be able to deploy to the cluster.
    kubectl create clusterrolebinding jenkins-deploy --clusterrole=cluster-admin --serviceaccount=default:cd-jenkins

EOF

