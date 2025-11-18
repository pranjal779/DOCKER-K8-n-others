kubectl get nodes --output yaml | grep -A4 addresses

gcloud compute networks describe privatenet

gcloud compute networks list

gcloud compute networks subnets describe SUBNET_NAME \
    --region="us-east1"

gcloud compute ssh source-instance --zone=$ZONE
