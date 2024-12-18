# FROM node:20.16.0 as build-stage
FROM node:20.16.0

WORKDIR /omniai-doc

COPY package*.json ./

RUN npm install -g npm@10.8.1

RUN npm install

COPY . .

RUN npm run build


# FROM nginx:stable-alpine as production-stage

# COPY ./docker/nginx.conf /etc/nginx/nginx.conf

# RUN rm -rf /usr/share/nginx/html/*

# COPY --from=build-stage /omniai-doc/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["npm", "run", "docker"]