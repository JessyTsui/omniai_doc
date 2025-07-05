# Build stage
FROM node:20.16.0-alpine as build-stage

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source files
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM nginx:stable-alpine as production-stage

# Install curl for health checks
RUN apk add --no-cache curl

# Copy nginx configuration
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy built application from build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Note: nginx user already exists in nginx:stable-alpine image

# Set permissions for nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    mkdir -p /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp && \
    chown -R nginx:nginx /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]