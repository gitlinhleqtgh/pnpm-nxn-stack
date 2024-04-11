# Installs Node.js image
FROM node:20-alpine3.18

# sets the working directory for any RUN, CMD, COPY command
# all files we put in the Docker container running the server will be in /usr/src/app (e.g. /usr/src/app/package.json)
WORKDIR /projects

# Copies package.json, package-lock.json, tsconfig.json, .env to the root of WORKDIR
COPY ["pnpm-lock.yaml", "pnpm-workspace.yaml", "package.json", ".env", "./"]

COPY apps/api/package.json ./apps/api/
COPY apps/web/package.json ./apps/web/
COPY libs/types/package.json ./libs/types/
COPY . .

RUN npm install -g pnpm

# Installs all packages
RUN pnpm install

EXPOSE 3000 3001
# Runs the dev pnpm script to build & start the server
CMD pnpm run dev
