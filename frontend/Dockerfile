# Stage 1: Build the Flutter web app
FROM instrumentisto/flutter:3.35.4 AS build

# Set the working directory
WORKDIR /app

# Copy pubspec.yaml and get dependencies
COPY pubspec.yaml .
RUN flutter pub get

# Copy the rest of the application source code
COPY . .

# Build the web application
RUN flutter build web
RUN ls -la /app/build/web

# Stage 2: Serve the built app using a lightweight web server
FROM nginx:alpine

# Remove default Nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy the built web app from the 'build' stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]