# same version as AWS Lambda
# FROM node:13.4.0-buster-slim
FROM node:14.2.0-buster-slim

RUN mkdir -p /test-app

WORKDIR /test-app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

WORKDIR ./

# EXPOSE 9001
EXPOSE 80

RUN mkdir /var/logs
# run app
# CMD ["node" , "./dist/main.js"]

CMD ["node" , "./dist/main.js", "2>server.log"]
