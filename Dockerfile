# Multi-stage Dockerfile with two stages:
# Stage 1: Base image for building the app
FROM node:20 as base

WORKDIR /app

# Copy package files and install dependencies
COPY ./app/package*.json ./
RUN npm install --only=production

# Copy the rest of the application
COPY ./app .

# Stage 2: Distroless final image
FROM gcr.io/distroless/nodejs20 as production

WORKDIR /app

# Copy only necessary files from the base stage
COPY --from=base /app .

COPY --from=base /app/public/images ./images

# RUN npx nodemon app.js . 

EXPOSE 3000

CMD ["app.js"]
