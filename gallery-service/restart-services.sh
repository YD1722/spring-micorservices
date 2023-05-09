export AWS_PROFILE=yd
export AWS_REGION=ap-northeast-1
aws ecs update-service --force-new-deployment --service gallery-service --cluster spring-mesh-cluster --region=ap-northeast-1
aws ecs update-service --force-new-deployment --service gateway --cluster spring-mesh-cluster --region=ap-northeast-1