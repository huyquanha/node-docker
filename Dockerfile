FROM node:12.18.1 as base

WORKDIR /code

COPY ["package.json", "package-lock.json*", "./"]

FROM base as test
RUN npm ci
COPY . .
RUN npm run test

FROM test as prod
RUN npm prune --production
CMD ["node", "server.js"]