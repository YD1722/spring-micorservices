mvn clean install
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 008744601422.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t gallery-service .
docker tag gallery-service:latest 008744601422.dkr.ecr.ap-northeast-1.amazonaws.com/gallery-service:latest
docker push 008744601422.dkr.ecr.ap-northeast-1.amazonaws.com/gallery-service:latest

#aws ecs update-service --force-new-deployment --service gallery-service --cluster spring-microservices --region=ap-northeast-1