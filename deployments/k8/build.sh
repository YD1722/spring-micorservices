# Get the current directory
CURRENT_DIR=$(pwd)

# Set the project directory two folders up from the current directory
ROOT_DIR=$(dirname "$(dirname "$CURRENT_DIR")")

# Declare the SERVICES array
SERVICES=(
  "gallery-service"
  "image-service"
  #  "image-processing-service"
)

# Loop through the SERVICES array
for service in "${SERVICES[@]}"; do
  # Change directory to the service folder
  cd "$ROOT_DIR/$service"


// function -> build
  echo "Building submodule: $submodule"
  mvn clean install -Pk8

// function -> build images
  # Point the current shell to the minikube docker engine
  eval $(minikube docker-env)
  # Build the Docker image
  docker build -t "k8/$service:latest" .

done

# Change directory back to the original current directory
cd "$CURRENT_DIR"
