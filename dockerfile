FROM quay.io/bitnami/node:14

EXPOSE 8090

RUN npm install -g pnpm

WORKDIR /home/gqty

COPY pnpm-lock.yaml /home/gqty/

RUN pnpm fetch

COPY package.json /home/gqty/

RUN pnpm i

COPY prisma /home/gqty/prisma

RUN pnpm prisma generate

COPY src /home/gqty/src

RUN pnpm prepare

COPY tsconfig.json /home/gqty/

RUN pnpm typecheck

ENV NODE_ENV=production

CMD node ./dist/index.js