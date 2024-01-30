FROM alpine:3.11 AS build-stage
RUN apk add --update nodejs npm
WORKDIR /app/
COPY flask-app/package*.json flask-app/.babelrc flask-app/webpack.config.js ./
RUN npm install
RUN npm run build

FROM alpine:3.11
WORKDIR /app/
COPY flask-app/app.py flask-app/requirements.txt ./
RUN apk add python2
RUN apk update && apk add py-pip
RUN pip install -r requirements.txt
ENTRYPOINT [ "python","./app.py" ]
