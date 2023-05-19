import os
import sys

service_name = sys.argv[1]
mvn_goals = sys.argv[2] if len(sys.argv) > 2 else 'package'

# Navigate to the service directory
os.chdir(service_name)

# Execute mvn clean $MVN_GOALS
os.system(f"mvn clean {mvn_goals}")
