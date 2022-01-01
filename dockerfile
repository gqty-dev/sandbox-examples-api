FROM quay.io/bitnami/node:16-prod

EXPOSE 8090

WORKDIR /home/gqty

COPY pnpm-lock.yaml /home/gqty/

RUN npm install -g pnpm

RUN pnpm fetch

COPY package.json /home/gqty/

RUN pnpm i

COPY prisma /home/gqty/prisma

RUN pnpm prepare

COPY src /home/gqty/src

COPY tsconfig.json /home/gqty/

RUN pnpm typecheck

CMD ["pnpm", "start"]