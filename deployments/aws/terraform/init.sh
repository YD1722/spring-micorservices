export AWS_PROFILE=yd
export SPRING_PROFILES_ACTIVE=aws

CURRENT_DIR=$(pwd)
PROJECT_DIR=$(dirname "$(dirname "$(dirname "$PWD")")") # Set the project directory three folders up from the current directory

#submodules=("gallery-service" "image-service")
submodules=("image-service")

for submodule in "${submodules[@]}"; do
  echo "Navigating into submodule: $submodule"
  cd "$PROJECT_DIR/$submodule"

  # TODO: Check build using profile and still need to pass it at runtime
  echo "Building submodule: $submodule"
  mvn clean install -Paws

  # Replace hyphen with underscore in submodule name
  submodule_="${submodule//-/_}"

  login_command="aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 008744601422.dkr.ecr.ap-south-1.amazonaws.com"
  build_command="docker build -t $submodule_ ."
  tag_command="docker tag $submodule_:latest 008744601422.dkr.ecr.ap-south-1.amazonaws.com/$submodule_:latest"
  push_command="docker push 008744601422.dkr.ecr.ap-south-1.amazonaws.com/$submodule_:latest"
  update_service_command="aws ecs update-service --cluster wierd-arts --service $submodule_ --force-new-deployment"

  # Execute the commands
  eval "$login_command"
  eval "$build_command"
  eval "$tag_command"
  eval "$push_command"
  #  eval "$update_service_command"

  echo "Completed processing submodule: $submodule"
done
