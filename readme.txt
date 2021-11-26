
first setup aws profile in cli.

export,

export ENV=dev
export REGION=us-east-1
export BUCKET_NAME=demo-eks-bucket-1123456
export AWS_PROFILE=nameofprofile

then create s3 bucket as backend for terraform steps mentioned in s3.txt.

last hit terraform command 

terraform init -backend-config="bucket=$BUCKET_NAME" -backend-config="key=$ENV/terraform-state" -backend-config="region=$REGION"

terraform plan -out "demo.tfplan"

once done

export REGION=us-east-1
export EKS_CLUSTER_NAME=my-cluster-dev

aws eks --region $REGION update-kubeconfig --name $EKS_CLUSTER_NAME
