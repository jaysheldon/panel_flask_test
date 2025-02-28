#!/bin/bash

# Set variables
PROJECT_ID=$(gcloud config get-value project)
APP_NAME="panel_flask_test"
REGION="us-central1"
REPO_URL="https://github.com/jaysheldon/$APP_NAME.git"
REPO_NAME=$APP_NAME
SERVICE_NAME=$APP_NAME
GITHUB_USER="jaysheldon"

# Check if the repository exists, if not, create it
if ! gh repo view $GITHUB_USER/$REPO_NAME > /dev/null 2>&1; then
  gh repo create $GITHUB_USER/$REPO_NAME --public --source=. --remote=origin
fi

# Add remote repository (if not already added)
if ! git remote | grep -q origin; then
  git remote add origin $REPO_URL
fi

# Push changes to GitHub
git add .
git commit -m "Deploying changes"
git push -u origin main
