# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Update and install necessary dependencies for both frontend and backend
RUN apt-get update && \
    apt-get install -y python3 python3-pip nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the entire application to the container
COPY . .

# Install backend dependencies
RUN python3 -m pip install -r community-challenge/requirements.txt

# Install frontend dependencies and build the Vue.js application
RUN cd src && \
    npm install && \
    npm run build

# Copy nginx.conf to the appropriate location
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the startup script
COPY start.sh /app/start.sh

# Expose the ports for Nginx and Flask
EXPOSE 80
EXPOSE 5000
EXPOSE 8080
# Make the script executable
RUN chmod +x /app/start.sh

# Start the startup script
CMD ["/app/start.sh"]
