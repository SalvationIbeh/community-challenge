#!/bin/bash

# Start Nginx in the background
nginx -g "daemon off;" &

# Start the Flask application
python3 community-challenge/main.py &

# Start the Vue.js development server
cd community-challenge/src
npm run serve

