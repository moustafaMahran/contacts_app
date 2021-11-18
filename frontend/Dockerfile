FROM node:latest
WORKDIR /app
COPY package.json ./
RUN npm install -g ionic
RUN npm install
COPY . /app