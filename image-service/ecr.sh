export AWS_PROFILE=yd
export AWS_REGION=ap-southeast-1

mvn clean install
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 008744601422.dkr.ecr.ap-south-1.amazonaws.com
docker build -t gallery_service .
docker tag gallery_service:latest 008744601422.dkr.ecr.ap-south-1.amazonaws.com/gallery_service:latest
docker push 008744601422.dkr.ecr.ap-south-1.amazonaws.com/gallery_service:latest

#TODO: without tagging it wasn't pushed