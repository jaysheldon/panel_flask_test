#!/bin/bash

# Build the Docker image
docker build -t gcr.io/YOUR_PROJECT_ID/YOUR_IMAGE_NAME .

# Push the Docker image to Google Container Registry
docker push gcr.io/YOUR_PROJECT_ID/YOUR_IMAGE_NAME

# Deploy the image to Cloud Run
gcloud run deploy YOUR_SERVICE_NAME \
  --image gcr.io/YOUR_PROJECT_ID/YOUR_IMAGE_NAME \
  --platform managed \
  --region YOUR_REGION \
  --allow-unauthenticated