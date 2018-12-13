#!/bin/bash

PRJ_NAME="toy_app"
APP_NAME="toyapp"


TAG='1.1'
docker build --tag "$APP_NAME:$TAG" --tag "$APP_NAME:latest" -f Dockerfile .
REPO_URL="266981040939.dkr.ecr.us-east-1.amazonaws.com/toy-app/$PRJ_NAME/$APP_NAME"

echo "Tagging images with Docker repository URL"
docker tag "$APP_NAME:$TAG" "$REPO_URL:$TAG"
docker tag "$APP_NAME:latest" "$REPO_URL:latest"

$(aws ecr get-login --region us-east-1 --no-include-email)


#push to repository
docker push "$REPO_URL:$TAG"
docker push "$REPO_URL:latest"
