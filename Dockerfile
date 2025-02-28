# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

ENV PYTHONUNBUFFERED=1

# Copy the requirements file first to leverage Docker's caching mechanism
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Install watchdog for hot reloading
RUN pip install watchdog

# Install Nginx
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run both Flask, Panel, and Nginx using a process manager
CMD ["sh", "-c", "flask run --host=0.0.0.0 --port=5000 --reload & panel serve panel_app.py --address=0.0.0.0 --port=5006 --prefix /panel --autoreload --allow-websocket-origin=localhost:8080 & nginx -g 'daemon off;'"]