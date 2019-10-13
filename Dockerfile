# install dependencies and build our application
FROM node:alpine as builder
WORKDIR '/home/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# copy build folder, paste into nginx container, serve app via nginx
FROM nginx
EXPOSE 80
COPY --from=builder /home/app/dist /usr/share/nginx/html
