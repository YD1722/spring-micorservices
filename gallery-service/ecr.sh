export AWS_PROFILE=yd
export AWS_REGION=ap-northeast-1
mvn clean install
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 008744601422.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t gallery-service .
docker tag gallery-service:latest 008744601422.dkr.ecr.ap-northeast-1.amazonaws.com/gallery-service:latest
docker push 008744601422.dkr.ecr.ap-northeast-1.amazonaws.com/gallery-service:latest

