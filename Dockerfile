# Base image: Node.js LTS on Alpine Linux (small image)
FROM node:lts-alpine
# update OS, install bash and clean all installation files
RUN apk update && \
    apk add --no-cache bash && \
    rm -rf /var/cache/apk/*
# create directory server and ...
RUN mkdir -p /server
# set it as working directory
WORKDIR /server
# copy all local files in the backend into
# working directory
COPY backend/ .
# install all nodejs dependencies
RUN npm install --omit=dev --no-audit --no-fund
# expose port 3000 of the app
EXPOSE 3000
# run server
CMD ["node", "index.js"]
