FROM rustedwizard/nodejs:latest_lts AS base

LABEL Maintainer="Rusted Wizard"
RUN npm install -g http-server

FROM rustedwizard/nodejs:latest_lts as build
RUN npm install -g @angular/cli
WORKDIR /app
COPY . /app
RUN npm install \
    ; npm run build -- --prod

FROM base as prod
COPY --from=build /app/dist .
WORKDIR /PersonalStaticWeb
EXPOSE 80
ENV PORT 80
CMD [ "http-server" ]
