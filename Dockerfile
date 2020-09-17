# use a node base container image
FROM node:lts-alpine
MAINTAINER AntonR
ADD web-server.js /web-server.js
ENTRYPOINT ["node", "web-server.js"]
