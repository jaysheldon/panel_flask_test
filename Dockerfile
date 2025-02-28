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

# Install Nginx and Supervisord
RUN apt-get update && apt-get install -y nginx supervisor && apt-get clean

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the Supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Add logging to supervisord
RUN echo '[supervisord]\nlogfile=/var/log/supervisord.log\nlogfile_maxbytes=50MB\nlogfile_backups=10\nloglevel=info\npidfile=/var/run/supervisord.pid\n' >> /etc/supervisor/supervisord.conf

# Run Supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]