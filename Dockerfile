FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
RUN mkdir -p /app/node_modules/.cache && chmod -R 777 /app/node_modules/.cache
COPY . . 
RUN npm run build 

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html