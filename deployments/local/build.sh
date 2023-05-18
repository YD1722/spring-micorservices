# Profile to use during the Maven build
PROFILE="dev"

# Get the current directory
CURRENT_DIR=$(pwd)
# Set the project directory two folders up from the current directory
PROJECT_DIR=$(dirname "$(dirname "$CURRENT_DIR")")

cd "$PROJECT_DIR"

mvn clean install -DskipTests
