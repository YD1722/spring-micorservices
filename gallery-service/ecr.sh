mvn clean install -Paws

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 008744601422.dkr.ecr.ap-south-1.amazonaws.com

docker build -t gallery_service .
docker tag gallery_service:latest 008744601422.dkr.ecr.ap-south-1.amazonaws.com/gallery_service:latest
docker push 008744601422.dkr.ecr.ap-south-1.amazonaws.com/gallery_service:latest

aws ecs update-service --cluster wierd-arts --service gallery_service --force-new-deployment

#TODO: without tagging it wasn't pushed
