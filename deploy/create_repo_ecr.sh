cd ..

# test-app is folder location of application
cd test-app

PACKAGE_VERSION=$(node -p -e "require('./package.json').version")

APP_NAME=test-app
ECR_REPO_NAME=test-app-repo

# aws configuration - SET ACCESS_KEY , ACCESS_SECRET_KEY ,AWS_RETION, and PROFILE
aws configure set aws_access_key_id XXXXXXXXXXXXXXXXXXXXXXXXX  --profile dev
aws configure set aws_secret_access_key XXXXXXXXXXXXXXXXXXXXXXXXX --profile dev
aws configure set region ap-southeast-1 --profile dev
aws configure set output json --profile dev

export AWS_REGION=ap-southeast-1
export AWS_PROFILE=dev

# create repository
aws ecr create-repository --repository-name  "$ECR_REPO_NAME"

echo "ECR repo created and get the Repo Name from here."

docker build -t "$APP_NAME":"$PACKAGE_VERSION"  .

# ECR Repository Path =  466551463358.dkr.ecr.ap-southeast-1.amazonaws.com/dev-ops-reader:2.0.0

echo "docker image created with package version :$PACKAGE_VERSION"

# XXXXXX relace with ECR Id
docker tag "$APP_NAME:$PACKAGE_VERSION" "XXXXXXXXXXXXXXXXXXXXXXXXX.dkr.ecr.ap-southeast-1.amazonaws.com/$ECR_REPO_NAME:$PACKAGE_VERSION"

$(aws ecr get-login --no-include-email --no-include-email | sed 's|https://||')

docker push "XXXXXXXXXXXXXXXXXXXXXXXXX.dkr.ecr.ap-southeast-1.amazonaws.com/$ECR_REPO_NAME:$PACKAGE_VERSION"
