FROM node:alpine as builder
WORKDIR '/app'

ENV HTTP_PROXY "http://genproxy:8080"
ENV HTTPS_PROXY "http://genproxy:8080"

RUN npm config set registry http://registry.npmjs.org/ --global
COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html