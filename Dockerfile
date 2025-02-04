ARG NODE_VERSION=node:18-alpine
FROM $NODE_VERSION AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM $NODE_VERSION

WORKDIR /app
COPY --from=builder /app ./

ENV NODE_ENV=production
EXPOSE 3000

CMD [ "node", "/app/.output/server/index.mjs" ]
