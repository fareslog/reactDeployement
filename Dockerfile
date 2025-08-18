# Stage 1: Build React application
FROM node:20-alpine AS builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run lint
RUN npm run build

# Stage 2: Export dist files
FROM scratch AS export-stage
COPY --from=builder /app/dist /dist

# Stage 3: Production image
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]