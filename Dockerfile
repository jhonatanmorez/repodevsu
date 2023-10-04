FROM node:18.15.0 as builder
ENV NODE_ENV="prod"

COPY . /app
WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
